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

# some of the resource does not support destroy so create unit id for name_prefix
resource "random_string" "id" {
  length  = 4
  upper   = false
  special = false
}

resource "time_static" "activation_date" {}
resource "random_string" "shared_secret" {
  length  = 40
  lower   = true
  special = false
}
locals {
  ba_roles        = ["roles/backupdr.computeEngineOperator", "roles/logging.logWriter", "roles/iam.serviceAccountUser"]
  key_ring_roles  = ["roles/cloudkms.cryptoKeyEncrypterDecrypter", "roles/cloudkms.admin"]
  enable_services = ["cloudkms.googleapis.com", "cloudresourcemanager.googleapis.com", "compute.googleapis.com", "iam.googleapis.com", "logging.googleapis.com"]
  profiles = {
    STANDARD_FOR_COMPUTE_ENGINE_VMS = {
      boot_disk_type         = "pd-standard"
      boot_disk_size         = "200"
      snap_pool_disk_size    = "10"
      primary_pool_disk_size = "200"
      machine_type           = "e2-standard-4"
    },
    STANDARD_FOR_DATABASES_VMWARE_VMS = {
      boot_disk_type         = "pd-balanced"
      boot_disk_size         = "200"
      snap_pool_disk_size    = "4096"
      primary_pool_disk_size = "200"
      machine_type           = "n2-standard-16"
    }
  }
}

locals {
  timestamp_sanitized = sum([time_static.activation_date.unix, 86400])
  shared_secret       = "${random_string.shared_secret.result}00000000${format("%x", local.timestamp_sanitized)}"
  ba_service_account  = var.create_ba_service_account ? join("", google_service_account.ba_service_account[*].email) : var.ba_service_account
  ba_randomised_name  = join("-", tolist([var.ba_name, random_string.id.id]))
}

# make sure the subnet exist.
data "google_compute_subnetwork" "ba_subnet" {
  name    = var.subnet
  project = var.vpc_host_project_id
  region  = var.region

  lifecycle {
    postcondition {
      condition     = self.private_ip_google_access == true
      error_message = "Make sure subnet exists and private_ip_google_access is required to be enabled!"
    }
  }
}

# Enable required services
resource "google_project_service" "enable_services" {
  project            = var.ba_project_id
  for_each           = toset(local.enable_services)
  service            = each.key
  disable_on_destroy = false
  depends_on         = [data.google_compute_subnetwork.ba_subnet]
}

# create service account for BA appliance
resource "google_service_account" "ba_service_account" {
  project      = var.ba_project_id
  count        = var.create_ba_service_account ? 1 : 0
  account_id   = var.ba_name
  display_name = "Backup DR Appliance Service Account"
  depends_on   = [google_project_service.enable_services]
}

# Assign the required permissions for BA Appliance service account.
resource "google_project_iam_member" "ba_service_account_roles" {
  project    = var.ba_project_id
  for_each   = var.assign_roles_to_ba_sa ? toset(local.ba_roles) : []
  member     = "serviceAccount:${local.ba_service_account}"
  role       = each.key
  depends_on = [google_project_service.enable_services]
}


# give BA service account permissions to access OnVault ba_vault_metadata
resource "google_project_iam_member" "ba_service_vault_role" {
  project = var.ba_project_id
  count   = var.assign_roles_to_ba_sa ? 1 : 0
  role    = "roles/backupdr.cloudStorageOperator"
  member  = "serviceAccount:${local.ba_service_account}"
  condition {
    title       = "${local.ba_randomised_name}-cloud-storage-metadata"
    description = "Permissions for storing GCE VM instance backup metadata in bucket"
    expression  = "resource.name.startsWith(\"projects/_/buckets/${local.ba_randomised_name}\")"
  }
}

# create keyring and crypto keys
resource "google_kms_key_ring" "ba_keyring" {
  project    = var.ba_project_id
  location   = var.region
  name       = "${local.ba_randomised_name}-keyring"
  depends_on = [google_project_service.enable_services]
}

resource "google_kms_crypto_key" "kek" {
  key_ring        = google_kms_key_ring.ba_keyring.id
  name            = "kek"
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7776000s"
  labels          = var.labels
  version_template {
    algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
    protection_level = "SOFTWARE"
  }
}

# assign the permission for BA Appliance to access keyring
resource "google_kms_key_ring_iam_member" "ba_keyring" {
  key_ring_id = google_kms_key_ring.ba_keyring.id
  for_each    = toset(local.key_ring_roles)
  role        = each.key
  member      = "serviceAccount:${local.ba_service_account}"
}

# create compute resource for BA Appliance VM.
resource "google_compute_disk" "boot_disk" {
  project                   = var.ba_project_id
  image                     = var.boot_image
  name                      = local.ba_randomised_name
  physical_block_size_bytes = 4096
  size                      = local.profiles[var.ba_appliance_type].boot_disk_size
  type                      = local.profiles[var.ba_appliance_type].boot_disk_type
  zone                      = var.zone
  labels                    = var.labels
  depends_on                = [google_project_service.enable_services]
}
resource "google_compute_disk" "ba_snapshot_pool" {
  project                   = var.ba_project_id
  name                      = "${local.ba_randomised_name}-snapshot-pool"
  physical_block_size_bytes = 4096
  size                      = local.profiles[var.ba_appliance_type].snap_pool_disk_size
  type                      = local.profiles[var.ba_appliance_type].boot_disk_type
  zone                      = var.zone
  labels                    = var.labels
  depends_on                = [google_project_service.enable_services]
}

resource "google_compute_disk" "ba_primary_pool" {
  project                   = var.ba_project_id
  name                      = "${local.ba_randomised_name}-primary-pool"
  physical_block_size_bytes = 4096
  size                      = local.profiles[var.ba_appliance_type].primary_pool_disk_size
  type                      = local.profiles[var.ba_appliance_type].boot_disk_type
  zone                      = var.zone
  labels                    = var.labels
  depends_on                = [google_project_service.enable_services]
}

resource "google_compute_attached_disk" "primary-pool" {
  project     = var.ba_project_id
  disk        = google_compute_disk.ba_primary_pool.id
  instance    = google_compute_instance.appliance.id
  device_name = "primary-pool"
}

resource "google_compute_attached_disk" "snapshot-pool" {
  project     = var.ba_project_id
  disk        = google_compute_disk.ba_snapshot_pool.id
  instance    = google_compute_instance.appliance.id
  device_name = "snapshot-pool"
}

resource "google_compute_instance" "appliance" {
  project = var.ba_project_id
  boot_disk {
    auto_delete = true
    device_name = local.ba_randomised_name
    source      = google_compute_disk.boot_disk.id
  }
  deletion_protection = true
  machine_type        = local.profiles[var.ba_appliance_type].machine_type
  metadata = {
    performance_pool_device = "snapshot-pool"
    primary_pool_device     = "primary-pool"
    kms_keyringname         = google_kms_key_ring.ba_keyring.name
    bootstrap_secret        = local.shared_secret
    bucket_prefix           = local.ba_randomised_name
    agm_instance_ivp_urls   = local.ivp_urls_string
  }
  name = local.ba_randomised_name
  network_interface {
    subnetwork         = data.google_compute_subnetwork.ba_subnet.name
    subnetwork_project = var.vpc_host_project_id
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
  zone = var.zone
  lifecycle {
    ignore_changes = [attached_disk, metadata]
  }
  labels     = var.labels
  tags       = var.network_tags
  depends_on = [google_project_service.enable_services, google_service_account.ba_service_account, data.http.fetch_ivp_urls]

}

# create firewall for the MC to communicate with BA appliance.
resource "google_compute_firewall" "ba_firewall_rule" {
  project = var.vpc_host_project_id
  count   = length(var.firewall_source_ip_ranges) > 0 ? 1 : 0
  allow {
    ports    = ["26", "443", "3260", "5107"]
    protocol = "tcp"
  }
  direction               = "INGRESS"
  name                    = "${local.ba_randomised_name}-firewall-rule"
  network                 = var.network
  priority                = 1000
  source_ranges           = var.firewall_source_ip_ranges
  target_service_accounts = [local.ba_service_account]
  depends_on              = [google_compute_instance.appliance]
}


### register BA appliance to management_server_endpoint
data "google_client_config" "default" {
  count = var.ba_registration ? 1 : 0
}

data "google_client_config" "fetch_ivp_urls" {
}

# call list management server. If baProxyUri exists then fetch the ivp urls for non psa deployments
data "http" "fetch_ivp_urls" {
  url    = "https://backupdr.googleapis.com/v1/projects/${var.ms_project_id}/locations/-/managementServers"
  method = "GET"
  request_headers = {
    Authorization = "Bearer ${data.google_client_config.fetch_ivp_urls.access_token}"
  }
}

locals {
  response_data_list_management_servers = jsondecode(data.http.fetch_ivp_urls.response_body)
  hasBAProxyUris = can(local.response_data_list_management_servers.managementServers[0].baProxyUri)
  ivp_url_string_1 = local.hasBAProxyUris ? local.response_data_list_management_servers.managementServers[0].baProxyUri[0] : null
  ivp_url_string_2 = local.hasBAProxyUris ? local.response_data_list_management_servers.managementServers[0].baProxyUri[1] : null
  ivp_urls_string = local.hasBAProxyUris ? join(",", [local.ivp_url_string_1, local.ivp_url_string_2]) : null
}

data "http" "actifio_session" {
  count  = var.ba_registration ? 1 : 0
  url    = "${var.management_server_endpoint}/session"
  method = "POST"
  request_headers = {
    Authorization = "Bearer ${data.google_client_config.default[count.index].access_token}"
  }

  lifecycle {
    postcondition {
      condition     = contains([200, 201, 204], self.status_code)
      error_message = "Actifio Session status code invalid. Make sure Management Server Configuration is correct!"
    }
  }
  depends_on = [google_compute_instance.appliance, google_compute_attached_disk.snapshot-pool, google_compute_attached_disk.primary-pool]
}

# tflint-ignore: terraform_unused_declarations
data "http" "actifio_register" {
  count  = var.ba_registration ? 1 : 0
  url    = "${var.management_server_endpoint}/cluster/register"
  method = "POST"
  request_headers = {
    Content-Type                = "application/json"
    Authorization               = "Bearer ${data.google_client_config.default[count.index].access_token}"
    backupdr-management-session = "Actifio ${jsondecode(data.http.actifio_session[count.index].response_body).session_id}"
  }

  request_body = jsonencode({
    "ipaddress"     = google_compute_instance.appliance.network_interface[0].network_ip
    "shared_secret" = local.shared_secret
    "deployBaWithoutPsa" = local.hasBAProxyUris ? true : false
    "serviceaccount"     = "${local.ba_service_account}"
  })

  retry {
    attempts     = 20
    min_delay_ms = 120000
    max_delay_ms = 180000
  }

  depends_on = [data.http.actifio_session, data.http.fetch_ivp_urls]
}
