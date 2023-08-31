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

output "instance_ip_addr" {
  value       = google_compute_instance.ba_instance.network_interface.0.network_ip
  description = "The private IP address of the BA Appliance."
}

output "bucket_prefix" {
  value       = local.bucket_prefix
  description = "GCE VM instance backup metadata in bucket"
}

output "ba_service_account" {
  value       = local.ba_service_account
  description = "BA Appliance service account"
}

output "vm_zone" {
  value       = google_compute_instance.ba_instance.zone
  description = "Zone where the vm appliance deployed."
}

output "vm_name" {
  value       = google_compute_instance.ba_instance.name
  description = "Name of the vm appliance."
}

output "vm_project_id" {
  value       = var.project_id
  description = "Project where BA is deployed"
}
