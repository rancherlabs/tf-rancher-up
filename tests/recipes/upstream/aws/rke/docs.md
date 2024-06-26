## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.53.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.10.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | 2.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws-ec2-upstream-cluster"></a> [aws-ec2-upstream-cluster](#module\_aws-ec2-upstream-cluster) | ../../../../../modules/infra/aws/ec2 | n/a |
| <a name="module_rancher_install"></a> [rancher\_install](#module\_rancher\_install) | ../../../../../modules/rancher | n/a |
| <a name="module_rke"></a> [rke](#module\_rke) | ../../../../../modules/distribution/rke | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.wait-docker-startup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.wait-k8s-services-startup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_bootstrap_rancher"></a> [bootstrap\_rancher](#input\_bootstrap\_rancher) | n/a | `bool` | `true` | no |
| <a name="input_docker_version"></a> [docker\_version](#input\_docker\_version) | n/a | `string` | `"20.10"` | no |
| <a name="input_ingress_provider"></a> [ingress\_provider](#input\_ingress\_provider) | n/a | `string` | `"nginx"` | no |
| <a name="input_install_docker"></a> [install\_docker](#input\_install\_docker) | n/a | `bool` | `true` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | n/a | `number` | `1` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"ec2-test"` | no |
| <a name="input_rancher_hostname"></a> [rancher\_hostname](#input\_rancher\_hostname) | n/a | `string` | `"rancher"` | no |
| <a name="input_rancher_password"></a> [rancher\_password](#input\_rancher\_password) | n/a | `string` | `"at-least-12-characters"` | no |
| <a name="input_ssh_private_key_path"></a> [ssh\_private\_key\_path](#input\_ssh\_private\_key\_path) | n/a | `any` | `null` | no |
| <a name="input_ssh_username"></a> [ssh\_username](#input\_ssh\_username) | n/a | `string` | `"ubuntu"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | `any` | `null` | no |
| <a name="input_waiting_time"></a> [waiting\_time](#input\_waiting\_time) | n/a | `number` | `180` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instances_private_ip"></a> [instances\_private\_ip](#output\_instances\_private\_ip) | n/a |
| <a name="output_instances_public_ip"></a> [instances\_public\_ip](#output\_instances\_public\_ip) | n/a |
| <a name="output_rancher_password"></a> [rancher\_password](#output\_rancher\_password) | Rancher Initial Custom Password |
| <a name="output_rancher_url"></a> [rancher\_url](#output\_rancher\_url) | Rancher URL |
