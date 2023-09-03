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

## create backupdr backup/recovery appliance
module "appliance" {
  source                     = "../.."
  assign_roles_to_ba_sa      = true
  ba_prefix                  = var.ba_name
  management_server_endpoint = var.management_server_endpoint
  create_serviceaccount      = true
  host_project_id            = var.project
  network                    = var.network
  project_id                 = var.project
  region                     = var.region
  subnet                     = var.subnet
  zone                       = var.zone
  require_registration       = true
}

