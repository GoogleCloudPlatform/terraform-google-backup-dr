/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# some of the resource does not support destory so create unit id for name_prefix
resource "random_id" "id" {
  byte_length = 2
}

resource "time_static" "activation_date" {}
resource "random_string" "shared_secret" {
  length  = 40
  lower   = true
  special = false
}
locals {
  timestamp_sanitized = sum([time_static.activation_date.unix, 86400])
  shared_secret       = "${random_string.shared_secret.result}00000000${format("%x", local.timestamp_sanitized)}"
}

locals {
  ba_service_account = var.create_serviceaccount ? join("", google_service_account.ba_service_account.*.email) : var.ba_service_account
  bucket_prefix      = join("-", tolist([var.ba_prefix, random_id.id.hex]))
}

# Enable required services
resource "google_project_service" "enable_services" {
  project            = var.project_id
  for_each           = toset(var.enable_services)
  service            = each.key
  disable_on_destroy = false
}

# create service account for BA appliance
resource "google_service_account" "ba_service_account" {
  project      = var.project_id
  count        = var.create_serviceaccount ? 1 : 0
  account_id   = var.ba_prefix
  display_name = "Backup DR Appliance Service Account"
  depends_on   = [google_project_service.enable_services]
}

# Assign the required permssions for BA Appliance service account.
resource "google_project_iam_member" "ba_service_account_roles" {
  project    = var.project_id
  for_each   = var.assign_roles_to_ba_sa ? toset(var.ba_roles) : []
  member     = "serviceAccount:${local.ba_service_account}"
  role       = each.key
  depends_on = [google_project_service.enable_services]
}


# give BA service account permissions to access OnVault ba_vault_metdata
resource "google_project_iam_member" "ba_service_vault_role" {
  project = var.project_id
  count   = var.assign_roles_to_ba_sa ? 1 : 0
  role    = "roles/backupdr.cloudStorageOperator"
  member  = "serviceAccount:${local.ba_service_account}"
  condition {
    title       = "${local.bucket_prefix}-cloud-storage-metadata"
    description = "Permissions for storing GCE VM instance backup metadata in bucket"
    expression  = "resource.name.startsWith(\"projects/_/buckets/${local.bucket_prefix}\")"
  }
}

# create keyring and crypto keys
resource "google_kms_key_ring" "ba_keyring" {
  project    = var.project_id
  location   = var.region
  name       = "${var.ba_prefix}-keyring-${random_id.id.hex}"
  depends_on = [google_project_service.enable_services]
}

resource "google_kms_crypto_key" "kek" {
  key_ring        = google_kms_key_ring.ba_keyring.id
  name            = "kek"
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7776000s"
  version_template {
    algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
    protection_level = "SOFTWARE"
  }
}

# assign the permission for BA Appliance to access keyring
resource "google_kms_key_ring_iam_member" "ba_keyring" {
  key_ring_id = google_kms_key_ring.ba_keyring.id
  for_each    = toset(var.key_ring_roles)
  role        = each.key
  member      = "serviceAccount:${local.ba_service_account}"
}

# create compute resource for BA Appliance VM.
# make sure the subnet exist.
data "google_compute_subnetwork" "ba_subnet" {
  # The subnet is pre-created per region in the default network
  name    = var.subnet
  project = var.host_project_id
  region  = var.region

  lifecycle {
    postcondition {
      condition     = self.private_ip_google_access == true
      error_message = "private_ip_google_access is required to be enabled on subnet!."
    }
  }
}

resource "google_compute_disk" "boot_disk" {
  project                   = var.project_id
  image                     = var.boot_image
  name                      = var.ba_prefix
  physical_block_size_bytes = 4096
  size                      = var.boot_disk_size
  type                      = var.boot_disk_type
  zone                      = var.zone
  depends_on                = [google_project_service.enable_services]
}
resource "google_compute_disk" "ba_snapshot_pool" {
  project                   = var.project_id
  name                      = "${var.ba_prefix}-snapshot-pool"
  physical_block_size_bytes = 4096
  size                      = var.snap_pool_disk_size
  type                      = var.boot_disk_type
  zone                      = var.zone
  depends_on                = [google_project_service.enable_services]
}

resource "google_compute_disk" "ba_primary_pool" {
  project                   = var.project_id
  name                      = "${var.ba_prefix}-primary-pool"
  physical_block_size_bytes = 4096
  size                      = var.primary_pool_disk_size
  type                      = var.boot_disk_type
  zone                      = var.zone
  depends_on                = [google_project_service.enable_services]
}

resource "google_compute_attached_disk" "primary-pool" {
  project     = var.project_id
  disk        = google_compute_disk.ba_primary_pool.id
  instance    = google_compute_instance.ba_instance.id
  device_name = "primary-pool"
}

resource "google_compute_attached_disk" "snapshot-pool" {
  project     = var.project_id
  disk        = google_compute_disk.ba_snapshot_pool.id
  instance    = google_compute_instance.ba_instance.id
  device_name = "snapshot-pool"
}

resource "google_compute_instance" "ba_instance" {
  project = var.project_id
  boot_disk {
    auto_delete = true
    device_name = var.ba_prefix
    source      = google_compute_disk.boot_disk.id
  }
  deletion_protection = true
  machine_type        = var.machine_type
  metadata = {
    performance_pool_device = "snapshot-pool"
    primary_pool_device     = "primary-pool"
    kms_keyringname         = google_kms_key_ring.ba_keyring.name
    bootstrap_secret        = local.shared_secret
    bucket_prefix           = local.bucket_prefix
  }
  name = var.ba_prefix
  network_interface {
    subnetwork         = data.google_compute_subnetwork.ba_subnet.name
    subnetwork_project = var.host_project_id
  }
  service_account {
    email  = local.ba_service_account
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = true
    enable_vtpm                 = true
  }
  zone       = var.zone
  depends_on = [google_project_service.enable_services]
  lifecycle {
    ignore_changes = [attached_disk, metadata]
  }

  tags = var.vm_tags
}

# create firewall for the MC to communicate with BA applaince.
resource "google_compute_firewall" "ba_firewall_rule" {
  project = var.host_project_id
  count   = length(var.source_ranges) > 0 ? 1 : 0
  allow {
    ports    = ["26", "443", "3260", "5107"]
    protocol = "tcp"
  }
  direction               = "INGRESS"
  name                    = "${var.ba_prefix}-firewall-rule"
  network                 = var.network
  priority                = 1000
  source_ranges           = var.source_ranges
  target_service_accounts = [local.ba_service_account]
}


### register BA appliance to management_server_endpoint
data "google_client_config" "default" {
  count = var.require_registration ? 1 : 0
}

data "http" "actifio_session" {
  count  = var.require_registration ? 1 : 0
  url    = "${var.management_server_endpoint}/session"
  method = "POST"
  request_headers = {
    Authorization = "Bearer ${data.google_client_config.default[count.index].access_token}"
  }

  lifecycle {
    postcondition {
      condition     = contains([200, 201, 204], self.status_code)
      error_message = "Actifio Session status code invalid"
    }
  }
}

data "http" "actifio_register" {
  count  = var.require_registration ? 1 : 0
  url    = "${var.management_server_endpoint}/cluster/register"
  method = "POST"
  request_headers = {
    Content-Type                = "application/json"
    Authorization               = "Bearer ${data.google_client_config.default[count.index].access_token}"
    backupdr-management-session = "Actifio ${jsondecode(data.http.actifio_session[count.index].response_body).session_id}"
  }

  request_body = jsonencode({
    "ipaddress"     = google_compute_instance.ba_instance.network_interface.0.network_ip
    "shared_secret" = local.shared_secret
  })

  retry {
    attempts     = 20
    min_delay_ms = 120000
    max_delay_ms = 180000
  }

  depends_on = [data.http.actifio_session]
}
