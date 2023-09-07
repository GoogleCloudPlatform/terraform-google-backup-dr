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
  source  = "terraform-google-modules/backup-dr/google"
  version = "~> 0.1"

  assign_roles_to_ba_sa      = true
  ba_prefix                  = var.ba_name
  management_server_endpoint = var.mgmt_api
  create_serviceaccount      = true
  host_project_id            = var.project
  network                    = var.network
  project_id                 = var.project
  region                     = var.region
  subnet                     = var.subnet
  zone                       = var.zone
  require_registration       = true
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assign\_roles\_to\_ba\_sa | assign roles to the BA service account | `bool` | n/a | yes |
| ba\_appliance\_type | provide BA appliance type | `string` | n/a | yes |
| ba\_name | provide the BA name (random 4 char will be added as suffix) | `string` | n/a | yes |
| ba\_project\_id | provide the project id | `string` | n/a | yes |
| ba\_registration | toggle flag to run appliance register API call. We recommended to make it false, once appliance is successfully registered. | `string` | `"true"` | no |
| ba\_service\_account | provide existing BA service account name | `string` | `"none"` | no |
| boot\_image | provide the base boot image for appliance. Dont modify for update/upgrade, refer management server console | `string` | `"projects/backupdr-images/global/images/sky-11-0-5-447"` | no |
| create\_ba\_service\_account | create BA service account | `bool` | n/a | yes |
| firewall\_source\_ip\_ranges | provide the IP ranges that needs to be allowed for appliance to reach management server | `list(string)` | `[]` | no |
| labels | A set of key/value label pairs to assign to the resources deployed. | `map(string)` | `{}` | no |
| management\_server\_endpoint | provide management server API endpoint URL ex. https://uri/actifio | `string` | n/a | yes |
| network | provide gcp network | `string` | n/a | yes |
| region | provide gcp region | `string` | n/a | yes |
| subnet | provide gcp subnet | `string` | n/a | yes |
| vm\_tags | Tags for appliance VM | `list(string)` | `[]` | no |
| vpc\_host\_project\_id | provide the vpc host project id | `string` | n/a | yes |
| zone | provide gcp zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ba\_name | Name of the vm appliance. |
| ba\_project\_id | Project where BA is deployed |
| ba\_randomised\_name | GCE VM instance backup metadata in bucket |
| ba\_service\_account | BA Appliance service account |
| instance\_ip\_addr | The private IP address of the BA Appliance. |
| zone | Zone where the vm appliance deployed. |

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
