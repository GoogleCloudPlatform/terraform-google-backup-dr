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

variable "host_project_id" {
  type = string
}

variable "ba_prefix" {
  type = string
}

variable "source_ranges" {
  type    = list(string)
  default = []
}

variable "require_registration" {
  type    = string
  default = "true"
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "network" {
  type    = string
  default = "default"
}

variable "subnet" {
  type = string
}

variable "management_server_endpoint" {
  type = string
}

variable "enable_services" {
  type    = list(string)
  default = ["cloudkms.googleapis.com", "cloudresourcemanager.googleapis.com", "compute.googleapis.com", "iam.googleapis.com", "logging.googleapis.com"]
}

variable "boot_image" {
  type    = string
  default = "projects/backupdr-images/global/images/sky-11-0-5-447"
}

variable "boot_disk_type" {
  type    = string
  default = "pd-ssd"
}

variable "boot_disk_size" {
  type    = number
  default = 200
}

variable "snap_pool_disk_size" {
  type    = number
  default = 4096
}

variable "primary_pool_disk_size" {
  type    = number
  default = 200
}

variable "machine_type" {
  type    = string
  default = "e2-standard-16"
}

variable "ba_roles" {
  type    = list(string)
  default = ["roles/backupdr.computeEngineOperator", "roles/logging.logWriter", "roles/iam.serviceAccountUser"]
}

variable "key_ring_roles" {
  type    = list(string)
  default = ["roles/cloudkms.cryptoKeyEncrypterDecrypter", "roles/cloudkms.admin"]
}

variable "vm_tags" {
  type        = list(string)
  description = "Tags for VMs"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "A set of key/value label pairs to assign to the resources deployed."
  default     = {}
}

variable "create_serviceaccount" {
  type        = bool
  description = "create BA service account"
}

variable "assign_roles_to_ba_sa" {
  type        = bool
  description = "assign roles to the BA service account"
}

variable "ba_service_account" {
  type        = string
  description = "BA service account"
  default     = "none"
}