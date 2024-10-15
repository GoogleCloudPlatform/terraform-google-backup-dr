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
  description = "Provide the project ID where you want to deploy the backup/recovery appliance."
}

variable "vpc_host_project_id" {
  type        = string
  description = "Provide the VPC host project ID. In case of a non-shared (dedicated) VPC, this will be the  same as the backup/recovery appliance project ID. In case of shared VPC, this will be the project ID of the host VPC project."
}

variable "ba_name" {
  type        = string
  description = "Provide a name for the backup/recovery appliance. The name will be suffixed with four random characters."
}

variable "firewall_source_ip_ranges" {
  type        = list(string)
  default     = []
  description = "Provide the IP ranges to allow the firewall communication between the management console, the appliance, and other subnets where workloads need to be backed up."
}

variable "ba_registration" {
  type        = string
  default     = "true"
  description = "Flag to register the backup/recovery appliance with the management console. We recommend changing it to false, once the appliance is successfully registered."
}

variable "region" {
  type        = string
  description = "Provide a region where you want to deploy a backup/recovery appliance."
}

variable "zone" {
  type        = string
  description = "Provide a zone within the selected region where you want to deploy a backup/recovery appliance."
}

variable "network" {
  type        = string
  description = "Provide a network which the appliance will be part of."
}

variable "subnet" {
  type        = string
  description = "Provide a network subnet which the appliance will be part of."
}

variable "management_server_endpoint" {
  type        = string
  description = "Provide a management console endpoint URL. For example, https://bmc-xxxx-dot-us-central1.backupdr.googleusercontent.com/actifio"
}

variable "boot_image" {
  type        = string
  default     = "projects/backupdr-images/global/images/sky-11-0-13-278"
  description = "Provide the boot image for backup/recovery appliance.  Don’t modify this variable to update or upgrade the appliance version. You can upgrade the appliance only through the Backup and DR Service management console."
}

variable "network_tags" {
  type        = list(string)
  description = "Provide the network tags for backup/recovery appliance VM. These tags allow you to apply firewall rules and routes to a specific instance or set of instances."
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "A set of key-value label pairs to be assigned to the deployed backup/recovery appliance."
  default     = {}
}

variable "create_ba_service_account" {
  type        = bool
  description = "Flag to create a service account for backup/recovery appliance."
}

variable "assign_roles_to_ba_sa" {
  type        = bool
  description = "Flag to assign the necessary roles to the backup/recovery appliance service account."
}

variable "ba_service_account" {
  type        = string
  description = "Use this if you want to use an existing service account with the backup/recovery appliance. This variable will be ignored if the create_ba_service_account variable is set to true."
  default     = "none"
}

variable "ba_appliance_type" {
  type        = string
  description = "Specify appliance type that you want to deploy. Supported appliance types are: [ \"STANDARD_FOR_COMPUTE_ENGINE_VMS\" , \"STANDARD_FOR_DATABASES_VMWARE_VMS\" ]"
  validation {
    condition     = contains(["STANDARD_FOR_COMPUTE_ENGINE_VMS", "STANDARD_FOR_DATABASES_VMWARE_VMS"], var.ba_appliance_type)
    error_message = "Valid value is one of the following: STANDARD_FOR_COMPUTE_ENGINE_VMS, STANDARD_FOR_DATABASES_VMWARE_VMS."
  }
}
