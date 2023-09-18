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

## create backupdr backup appliance
module "backupdr_complete_example" {
  source  = "../../../examples/backupdr_complete_example"
  project = var.project
  region  = "us-central1"

  ## network vars
  network     = "custom-network"
  subnet      = "custom-subnet"
  subnet_cidr = "10.20.0.0/16"

  ## MC vars
  mc_name         = "ms-console-custom"
  mc_type         = "BACKUP_RESTORE"
  mc_peering_mode = "PRIVATE_SERVICE_ACCESS"

  ## appliance vars
  appliances = {
    "backup-recovery-appliance001" = {
      vpc_host_project_id       = "gcp-project-id"
      ba_project_id             = "gcp-project-id"
      region                    = "us-central1"
      zone                      = "us-central1-a"
      ba_registration           = true
      ba_appliance_type         = "STANDARD_FOR_COMPUTE_ENGINE_VMS"
      create_ba_service_account = true
      assign_roles_to_ba_sa     = true
    },
    "backup-recovery-appliance002" = {
      vpc_host_project_id       = "gcp-project-id"
      ba_project_id             = "gcp-project-id"
      region                    = "us-central1"
      zone                      = "us-central1-a"
      ba_registration           = true
      ba_appliance_type         = "STANDARD_FOR_DATABASES_VMWARE_VMS"
      create_ba_service_account = true
      assign_roles_to_ba_sa     = true
    }
  }
}


