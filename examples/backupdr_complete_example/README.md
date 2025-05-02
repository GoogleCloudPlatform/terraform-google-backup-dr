## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ba_appliance"></a> [ba\_appliance](#module\_ba\_appliance) | GoogleCloudPlatform/backup-dr/google | n/a |

## Resources

| Name | Type |
|------|------|
| [google_backup_dr_management_server.server](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/backup_dr_management_server) | resource |
| [google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/compute_subnetwork) | resource |
| [google_service_networking_connection.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/service_networking_connection) | resource |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| appliances | map of appliances with properties | <pre>map(object({<br>    management_server_endpoint = optional(string)<br>    vpc_host_project_id        = optional(string)<br>    network                    = optional(string)<br>    subnet                     = optional(string)<br>    region                     = optional(string)<br>    zone                       = optional(string)<br>    ba_project_id              = optional(string)<br>    ms_project_id              = optional(string)<br>    ba_registration            = optional(bool)<br>    ba_appliance_type          = string<br>    ba_service_account         = optional(string)<br>    assign_roles_to_ba_sa      = optional(bool)<br>    create_ba_service_account  = optional(bool)<br>    network_tags               = optional(list(string))<br>    boot_image                 = optional(string)<br>    labels                     = optional(map(string))<br>    firewall_source_ip_ranges  = optional(list(string))<br>  }))</pre> | `{}` | no |
| mc\_name | provide management server name | `string` | `"ms-console"` | no |
| mc\_type | provide management server type | `string` | `"BACKUP_RESTORE"` | no |
| network | n/a | `string` | `"custom-network"` | no |
| project\_id | n/a | `string` | n/a | yes |
| region | n/a | `string` | n/a | yes |
| subnet | n/a | `string` | `"custom-network"` | no |
| subnet\_cidr | n/a | `string` | `"10.20.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| appliances | n/a |
| ms\_console | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
