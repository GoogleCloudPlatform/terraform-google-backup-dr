## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.80.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ba_appliance"></a> [ba\_appliance](#module\_ba\_appliance) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [google_backup_dr_management_server.server](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/backup_dr_management_server) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/compute_network) | data source |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ba\_name | provide backup appliance server name | `string` | n/a | yes |
| management\_server\_endpoint | specify endpoint url for management server | `string` | n/a | yes |
| network | provide gcp network | `string` | n/a | yes |
| project | provide project id | `string` | n/a | yes |
| region | provide gcp region | `string` | n/a | yes |
| subnet | provide gcp subnetwork | `string` | n/a | yes |
| zone | provide gcp zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| appliance | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->