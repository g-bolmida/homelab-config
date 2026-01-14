<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.14 |
| <a name="requirement_b2"></a> [b2](#requirement\_b2) | 0.12.0 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | 3.7.0 |
| <a name="requirement_portainer"></a> [portainer](#requirement\_portainer) | 1.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_b2"></a> [b2](#provider\_b2) | 0.12.0 |
| <a name="provider_linode"></a> [linode](#provider\_linode) | 3.7.0 |
| <a name="provider_portainer"></a> [portainer](#provider\_portainer) | 1.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [b2_bucket.big-box-backup-bucket](https://registry.terraform.io/providers/Backblaze/b2/0.12.0/docs/resources/bucket) | resource |
| [b2_bucket.synology-backup-bucket](https://registry.terraform.io/providers/Backblaze/b2/0.12.0/docs/resources/bucket) | resource |
| [b2_bucket.teleport-auth-backup-bucket](https://registry.terraform.io/providers/Backblaze/b2/0.12.0/docs/resources/bucket) | resource |
| [linode_firewall.teleport-firewall](https://registry.terraform.io/providers/linode/linode/3.7.0/docs/resources/firewall) | resource |
| [linode_instance.teleport-server](https://registry.terraform.io/providers/linode/linode/3.7.0/docs/resources/instance) | resource |
| [portainer_stack.flaresolverr](https://registry.terraform.io/providers/portainer/portainer/1.21.0/docs/resources/stack) | resource |
| [portainer_stack.homeassistant](https://registry.terraform.io/providers/portainer/portainer/1.21.0/docs/resources/stack) | resource |
| [portainer_stack.n8n](https://registry.terraform.io/providers/portainer/portainer/1.21.0/docs/resources/stack) | resource |
| [portainer_stack.overseerr](https://registry.terraform.io/providers/portainer/portainer/1.21.0/docs/resources/stack) | resource |
| [portainer_stack.qbittorrent](https://registry.terraform.io/providers/portainer/portainer/1.21.0/docs/resources/stack) | resource |
| [portainer_environment.big_box](https://registry.terraform.io/providers/portainer/portainer/1.21.0/docs/data-sources/environment) | data source |
| [portainer_environment.local](https://registry.terraform.io/providers/portainer/portainer/1.21.0/docs/data-sources/environment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_b2_application_key"></a> [b2\_application\_key](#input\_b2\_application\_key) | n/a | `any` | n/a | yes |
| <a name="input_b2_application_key_id"></a> [b2\_application\_key\_id](#input\_b2\_application\_key\_id) | n/a | `any` | n/a | yes |
| <a name="input_linode_api_token"></a> [linode\_api\_token](#input\_linode\_api\_token) | n/a | `any` | n/a | yes |
| <a name="input_linode_root_password"></a> [linode\_root\_password](#input\_linode\_root\_password) | n/a | `any` | n/a | yes |
| <a name="input_portainer_api_key"></a> [portainer\_api\_key](#input\_portainer\_api\_key) | n/a | `any` | n/a | yes |
| <a name="input_portainer_endpoint"></a> [portainer\_endpoint](#input\_portainer\_endpoint) | n/a | `string` | `"https://192.168.1.5:9443"` | no |
| <a name="input_skip_ssl_verify"></a> [skip\_ssl\_verify](#input\_skip\_ssl\_verify) | n/a | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_big_box_environment_id"></a> [big\_box\_environment\_id](#output\_big\_box\_environment\_id) | n/a |
| <a name="output_local_environment_id"></a> [local\_environment\_id](#output\_local\_environment\_id) | n/a |
<!-- END_TF_DOCS -->