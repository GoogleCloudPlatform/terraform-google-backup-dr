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

variable "appliances" {
  type = map(object({
    management_server_endpoint = optional(string)
    vpc_host_project_id        = optional(string)
    network                    = optional(string)
    subnet                     = optional(string)
    region                     = optional(string)
    zone                       = optional(string)
    ba_project_id              = optional(string)
    ba_registration            = optional(bool)
    ba_appliance_type          = string
    ba_service_account         = optional(string)
    assign_roles_to_ba_sa      = optional(bool)
    create_ba_service_account  = optional(bool)
    network_tags               = optional(list(string))
    boot_image                 = optional(string)
    labels                     = optional(map(string))
    firewall_source_ip_ranges  = optional(list(string))
  }))
  default     = {}
  description = "map of appliances with properties"
}