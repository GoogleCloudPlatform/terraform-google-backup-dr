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
| appliances | map of appliances with properties | <pre>map(object({<br>    management_server_endpoint = optional(string)<br>    vpc_host_project_id        = optional(string)<br>    network                    = optional(string)<br>    subnet                     = optional(string)<br>    region                     = optional(string)<br>    zone                       = optional(string)<br>    ba_project_id              = optional(string)<br>    ba_registration            = optional(bool)<br>    ba_appliance_type          = string<br>    ba_service_account         = optional(string)<br>    assign_roles_to_ba_sa      = optional(bool)<br>    create_ba_service_account  = optional(bool)<br>    network_tags                    = optional(list(string))<br>    boot_image                 = optional(string)<br>    labels                     = optional(map(string))<br>    firewall_source_ip_ranges  = optional(list(string))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| appliances | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->