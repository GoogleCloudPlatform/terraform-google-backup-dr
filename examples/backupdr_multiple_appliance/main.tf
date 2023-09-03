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
module "multiple_appliances" {
  for_each                   = try(var.appliances, {})
  source                     = "../.."
  assign_roles_to_ba_sa      = true
  create_serviceaccount      = true
  ba_prefix                  = each.key
  management_server_endpoint = each.value.management_server_endpoint
  host_project_id            = each.value.host_project_id
  network                    = each.value.network
  project_id                 = each.value.project_id
  region                     = each.value.region
  subnet                     = each.value.subnet
  zone                       = each.value.zone
  require_registration       = each.value.require_registration
}

