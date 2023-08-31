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

data "google_compute_network" "network" {
  name = var.network
}

## create backupdr management server 
resource "google_backup_dr_management_server" "server" {
  provider = google-beta
  location = var.region
  name     = var.mc_name
  type     = var.mc_type
  networks {
    network      = data.google_compute_network.network.id
    peering_mode = var.mc_peering_mode
  }
}

## create backupdr backup appliance
module "ba_appliance" {
  source                     = "../.."
  assign_roles_to_ba_sa      = true
  ba_prefix                  = var.ba_name
  management_server_endpoint = google_backup_dr_management_server.server.management_uri.0.api
  create_serviceaccount      = true
  host_project_id            = var.project
  network                    = var.network
  project_id                 = var.project
  region                     = var.region
  subnet                     = var.subnet
  zone                       = var.zone
  require_registration       = false
  depends_on                 = [google_backup_dr_management_server.server]
}

