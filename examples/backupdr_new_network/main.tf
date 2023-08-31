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
  auto_create_subnetworks = false
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "global-psconnect-ip"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  prefix_length = 20
  network       = google_compute_network.network.id
}

resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_backup_dr_management_server" "server" {
  location = var.region
  name     = var.mc_name
  type     = var.mc_type
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
  network                  = google_compute_network.network.id
  private_ip_google_access = true
}

module "ba_appliance" {
  source                     = "../.."
  assign_roles_to_ba_sa      = true
  ba_prefix                  = var.ba_name
  management_server_endpoint = google_backup_dr_management_server.server.management_uri.0.api
  create_serviceaccount      = true
  host_project_id            = var.project
  network                    = google_compute_network.network.name
  project_id                 = var.project
  region                     = var.region
  subnet                     = google_compute_subnetwork.subnet.name
  zone                       = var.zone
  depends_on                 = [google_backup_dr_management_server.server]
}

