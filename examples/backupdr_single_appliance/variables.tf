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

variable "project" {
  type        = string
  description = "provide project id"
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
  description = "provide gcp subnetwork"
}

variable "management_server_endpoint" {
  type        = string
  description = "specify endpoint url for management server"
}

variable "ba_name" {
  type        = string
  description = "provide backup appliance server name"
}
