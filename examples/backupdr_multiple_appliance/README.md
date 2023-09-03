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
| appliances | map of appliances with properties | <pre>map(object({<br>    host_project_id            = string<br>    project_id                 = string<br>    management_server_endpoint = string<br>    network                    = string<br>    subnet                     = string<br>    region                     = string<br>    zone                       = string<br>    require_registration       = bool<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| appliances | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->