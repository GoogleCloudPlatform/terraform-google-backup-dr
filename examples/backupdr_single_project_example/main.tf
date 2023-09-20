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

resource "google_compute_network" "network" {
  name                    = var.network
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "global-psconnect-ip-${var.network}"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  prefix_length = 20
  project       = var.project_id
  network       = google_compute_network.network.id
}

resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_backup_dr_management_server" "server" {
  provider = google-beta
  location = var.region
  project  = var.project_id

  name = var.mc_name
  type = var.mc_type
  networks {
    network      = google_compute_network.network.id
    peering_mode = var.mc_peering_mode
  }
  depends_on = [google_service_networking_connection.default]
}

## setup subnet for ba appliance
resource "google_compute_subnetwork" "subnet" {
  name                     = var.subnet
  ip_cidr_range            = var.subnet_cidr
  region                   = var.region
  project                  = var.project_id
  network                  = google_compute_network.network.id
  private_ip_google_access = true
}

module "appliances" {
  for_each                   = try(var.appliances, {})
  source                     = "../.."
  create_ba_service_account  = each.value.create_ba_service_account
  assign_roles_to_ba_sa      = each.value.assign_roles_to_ba_sa
  ba_name                    = each.key
  ba_appliance_type          = each.value.ba_appliance_type
  management_server_endpoint = google_backup_dr_management_server.server.management_uri[0].api
  vpc_host_project_id        = var.project_id
  ba_project_id              = var.project_id
  network                    = google_compute_network.network.name
  region                     = each.value.region
  subnet                     = google_compute_subnetwork.subnet.name
  zone                       = each.value.zone
  firewall_source_ip_ranges  = ["${google_compute_global_address.private_ip_address.address}/${google_compute_global_address.private_ip_address.prefix_length}"]
  depends_on                 = [google_backup_dr_management_server.server, google_service_networking_connection.default]
}

