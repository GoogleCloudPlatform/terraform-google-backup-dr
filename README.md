# terraform-google-backup-dr

## Description
### Tagline
Terraform module for Google BackupDR components

### Detailed
The terraform-google-cloud-backup-dr module will help users to provision the backup/recovery appliances for their projects and integrate that with the Backup DR management console. Using this module now users can automate the  prerequisites  of having a backup/recovery appliance in place required for using Google Backup DR management console.


The resources/services/activations/deletions that this module will create/trigger are:

- Create backup/recovery appliance for backupDR in given GCP projects

### PreDeploy
To deploy this blueprint you must have an active billing account and billing permissions.

## Documentation
- [Backup/Recovery Appliance Concepts](https://cloud.google.com/backup-disaster-recovery/docs/concepts/manage-appliance)


## Usage
Basic usage of this module is as follows:

```hcl
module "backup_dr_appliance" {
  source  = "GoogleCloudPlatform/backup-dr/google//"
  version = "0.1.0"

  ba_project_id = "gcp-project-01"
  region        = "us-central1"
  zone          = "us-central1-a"

  vpc_host_project_id = "gcp-project-01"
  network             = "custom-network"
  subnet              = "custom-network"

  management_server_endpoint = "https://bmc-123455676-xxxxxxxx-dot-us-central1.backupdr.googleusercontent.com/actifio"
  ba_name                    = "backup-recovery-appliance"
  ba_appliance_type          = "STANDARD_FOR_COMPUTE_ENGINE_VMS"
  create_ba_service_account  = true
  assign_roles_to_ba_sa      = true
  ba_registration            = true
  firewall_source_ip_ranges  = ["10.128.64.0/20"]
  network_tags               = []
  labels                     = {
    managed-by = "terraform"
  }
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assign\_roles\_to\_ba\_sa | Flag to assign the necessary roles to the backup/recovery appliance service account. | `bool` | n/a | yes |
| ba\_appliance\_type | Specify appliance type that you want to deploy. Supported appliance types are: [ "STANDARD\_FOR\_COMPUTE\_ENGINE\_VMS" , "STANDARD\_FOR\_DATABASES\_VMWARE\_VMS" ] | `string` | n/a | yes |
| ba\_name | Provide a name for the backup/recovery appliance. The name will be suffixed with four random characters. | `string` | n/a | yes |
| ba\_project\_id | Provide the project ID where you want to deploy the backup/recovery appliance. | `string` | n/a | yes |
| ba\_registration | Flag to register the backup/recovery appliance with the management console. We recommend changing it to false, once the appliance is successfully registered. | `string` | `"true"` | no |
| ba\_service\_account | Use this if you want to use an existing service account with the backup/recovery appliance. This variable will be ignored if the create\_ba\_service\_account variable is set to true. | `string` | `"none"` | no |
| boot\_image | Provide the boot image for backup/recovery appliance.  Don’t modify this variable to update or upgrade the appliance version. You can upgrade the appliance only through the Backup and DR Service management console. | `string` | `"projects/backupdr-images/global/images/sky-11-0-12-320"` | no |
| create\_ba\_service\_account | Flag to create a service account for backup/recovery appliance. | `bool` | n/a | yes |
| firewall\_source\_ip\_ranges | Provide the IP ranges to allow the firewall communication between the management console, the appliance, and other subnets where workloads need to be backed up. | `list(string)` | `[]` | no |
| labels | A set of key-value label pairs to be assigned to the deployed backup/recovery appliance. | `map(string)` | `{}` | no |
| management\_server\_endpoint | Provide a management console endpoint URL. For example, https://bmc-xxxx-dot-us-central1.backupdr.googleusercontent.com/actifio | `string` | n/a | yes |
| network | Provide a network which the appliance will be part of. | `string` | n/a | yes |
| network\_tags | Provide the network tags for backup/recovery appliance VM. These tags allow you to apply firewall rules and routes to a specific instance or set of instances. | `list(string)` | `[]` | no |
| region | Provide a region where you want to deploy a backup/recovery appliance. | `string` | n/a | yes |
| subnet | Provide a network subnet which the appliance will be part of. | `string` | n/a | yes |
| vpc\_host\_project\_id | Provide the VPC host project ID. In case of a non-shared (dedicated) VPC, this will be the  same as the backup/recovery appliance project ID. In case of shared VPC, this will be the project ID of the host VPC project. | `string` | n/a | yes |
| zone | Provide a zone within the selected region where you want to deploy a backup/recovery appliance. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ba\_name | Name of the backup/recovery appliance provided as input. |
| ba\_project\_id | Project where backup/recovery appliance is deployed. |
| ba\_randomised\_name | The randomised name of backup/recovery appliance |
| ba\_service\_account | The service account used with the backup/recovery appliance. |
| instance\_ip\_addr | The private IP address of the backup/recovery appliance. |
| zone | Zone where the backup/recovery appliance is deployed. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### APIs

The terraform module will take care of enabling the required APIs to function the terraform module.

- Google Cloud Compute JSON API: `compute.googleapis.com`
- Google Cloud Resource Manager JSON API: `cloudresourcemanager.googleapis.com`
- Google Cloud KMS JSON API: `cloudkms.googleapis.com`
- Google Cloud IAM JSON API: `iam.googleapis.com`
- Google Cloud Logging JSON API: `logging.googleapis.com`

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
