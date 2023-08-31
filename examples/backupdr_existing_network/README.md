## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.76.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ba_appliance"></a> [ba\_appliance](#module\_ba\_appliance) | ../../modules/ba-appliance | n/a |

## Resources

| Name | Type |
|------|------|
| [google_backup_dr_management_server.server](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/backup_dr_management_server) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ba_name"></a> [ba\_name](#input\_ba\_name) | provide backup appliance server name | `string` | n/a | yes |
| <a name="input_mc_name"></a> [mc\_name](#input\_mc\_name) | provide management server name | `string` | `"ms-console"` | no |
| <a name="input_mc_peering_mode"></a> [mc\_peering\_mode](#input\_mc\_peering\_mode) | specify peering mode for management server | `string` | `"PRIVATE_SERVICE_ACCESS"` | no |
| <a name="input_mc_type"></a> [mc\_type](#input\_mc\_type) | provide management server type | `string` | `"BACKUP_RESTORE"` | no |
| <a name="input_network"></a> [network](#input\_network) | provide gcp network | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | provide project id | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | provide gcp region | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | provide gcp subnetwork | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | provide gcp zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ms_console"></a> [ms\_console](#output\_ms\_console) | n/a |