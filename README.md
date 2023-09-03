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
| ba\_prefix | n/a | `string` | n/a | yes |
| ba\_roles | n/a | `list(string)` | <pre>[<br>  "roles/backupdr.computeEngineOperator",<br>  "roles/logging.logWriter",<br>  "roles/iam.serviceAccountUser"<br>]</pre> | no |
| ba\_service\_account | BA service account | `string` | `"none"` | no |
| boot\_disk\_size | n/a | `number` | `200` | no |
| boot\_disk\_type | n/a | `string` | `"pd-ssd"` | no |
| boot\_image | n/a | `string` | `"projects/backupdr-images/global/images/sky-11-0-5-447"` | no |
| create\_serviceaccount | create BA service account | `bool` | n/a | yes |
| enable\_services | n/a | `list(string)` | <pre>[<br>  "cloudkms.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "compute.googleapis.com",<br>  "iam.googleapis.com",<br>  "logging.googleapis.com"<br>]</pre> | no |
| host\_project\_id | n/a | `string` | n/a | yes |
| key\_ring\_roles | n/a | `list(string)` | <pre>[<br>  "roles/cloudkms.cryptoKeyEncrypterDecrypter",<br>  "roles/cloudkms.admin"<br>]</pre> | no |
| labels | A set of key/value label pairs to assign to the resources deployed. | `map(string)` | `{}` | no |
| machine\_type | n/a | `string` | `"e2-standard-16"` | no |
| management\_server\_endpoint | n/a | `string` | n/a | yes |
| network | n/a | `string` | `"default"` | no |
| primary\_pool\_disk\_size | n/a | `number` | `200` | no |
| project\_id | n/a | `string` | n/a | yes |
| region | n/a | `string` | n/a | yes |
| require\_registration | n/a | `string` | `"true"` | no |
| snap\_pool\_disk\_size | n/a | `number` | `4096` | no |
| source\_ranges | n/a | `list(string)` | `[]` | no |
| subnet | n/a | `string` | n/a | yes |
| vm\_tags | Tags for VMs | `list(string)` | `[]` | no |
| zone | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ba\_service\_account | BA Appliance service account |
| bucket\_prefix | GCE VM instance backup metadata in bucket |
| instance\_ip\_addr | The private IP address of the BA Appliance. |
| vm\_name | Name of the vm appliance. |
| vm\_project\_id | Project where BA is deployed |
| vm\_zone | Zone where the vm appliance deployed. |

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
