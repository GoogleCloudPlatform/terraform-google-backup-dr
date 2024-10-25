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

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type    = string
  default = "custom-network"
}

variable "subnet" {
  type    = string
  default = "custom-network"
}

variable "subnet_cidr" {
  type    = string
  default = "10.20.0.0/16"
}


variable "mc_peering_mode" {
  type        = string
  description = "specify peering mode for management server"
  default     = "PRIVATE_SERVICE_ACCESS"
}

variable "mc_name" {
  type        = string
  description = "provide management server name"
  default     = "ms-console"
}

variable "mc_type" {
  type        = string
  description = "provide management server type"
  default     = "BACKUP_RESTORE"
}

variable "appliances" {
  type = map(object({
    management_server_endpoint = optional(string)
    vpc_host_project_id        = optional(string)
    network                    = optional(string)
    subnet                     = optional(string)
    region                     = optional(string)
    zone                       = optional(string)
    ba_project_id              = optional(string)
    ms_project_id              = optional(string)
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
