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

variable "ba_project_id" {
  type        = string
  description = "provide the project id"
}

variable "vpc_host_project_id" {
  type        = string
  description = "provide the vpc host project id"
}

variable "ba_name" {
  type        = string
  description = "provide the BA name (random 4 char will be added as suffix)"
}

variable "firewall_source_ip_ranges" {
  type        = list(string)
  default     = []
  description = "provide the IP ranges that needs to be allowed for appliance to reach management server"
}

variable "ba_registration" {
  type        = string
  default     = "true"
  description = "toggle flag to run appliance register API call. We recommended to make it false, once appliance is successfully registered."
}

variable "region" {
  type        = string
  description = "provide gcp region"
}

variable "zone" {
  type        = string
  description = "provide gcp zone"
}

variable "network" {
  type        = string
  description = "provide gcp network"
}

variable "subnet" {
  type        = string
  description = "provide gcp subnet"
}

variable "management_server_endpoint" {
  type        = string
  description = "provide management server API endpoint URL ex. https://uri/actifio"
}

variable "boot_image" {
  type        = string
  default     = "projects/backupdr-images/global/images/sky-11-0-5-447"
  description = "provide the base boot image for appliance. Dont modify for update/upgrade, refer management server console"
}

variable "network_tags" {
  type        = list(string)
  description = "Tags for appliance VM"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "A set of key/value label pairs to assign to the resources deployed."
  default     = {}
}

variable "create_ba_service_account" {
  type        = bool
  description = "create BA service account"
}

variable "assign_roles_to_ba_sa" {
  type        = bool
  description = "assign roles to the BA service account"
}

variable "ba_service_account" {
  type        = string
  description = "provide existing BA service account name"
  default     = "none"
}

variable "ba_appliance_type" {
  type        = string
  description = "provide BA appliance type"
  validation {
    condition     = contains(["STANDARD_FOR_COMPUTE_ENGINE_VMS", "STANDARD_FOR_DATABASES_VMWARE_VMS"], var.ba_appliance_type)
    error_message = "Valid value is one of the following: STANDARD_FOR_COMPUTE_ENGINE_VMS, STANDARD_FOR_DATABASES_VMWARE_VMS."
  }
}
