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
  for_each = try(var.appliances, {})

  source = "GoogleCloudPlatform/backup-dr/google"
  version = "0.3.0"

  vpc_host_project_id = each.value.vpc_host_project_id
  network             = each.value.network
  ba_project_id       = each.value.ba_project_id
  ms_project_id       = each.value.ms_project_id
  region              = each.value.region
  subnet              = each.value.subnet
  zone                = each.value.zone

  assign_roles_to_ba_sa     = each.value.assign_roles_to_ba_sa
  create_ba_service_account = each.value.create_ba_service_account
  ba_service_account        = each.value.ba_service_account

  ba_name                   = each.key
  ba_appliance_type         = each.value.ba_appliance_type
  boot_image                = each.value.boot_image
  labels                    = each.value.labels
  network_tags              = each.value.network_tags
  firewall_source_ip_ranges = each.value.firewall_source_ip_ranges

  ba_registration            = each.value.ba_registration
  management_server_endpoint = each.value.management_server_endpoint
}

