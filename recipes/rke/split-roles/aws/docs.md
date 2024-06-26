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
| <a name="module_aws-ec2-upstream-master-nodes"></a> [aws-ec2-upstream-master-nodes](#module\_aws-ec2-upstream-master-nodes) | ../../../../modules/infra/aws/ec2 | n/a |
| <a name="module_aws-ec2-upstream-worker-nodes"></a> [aws-ec2-upstream-worker-nodes](#module\_aws-ec2-upstream-worker-nodes) | ../../../../modules/infra/aws/ec2 | n/a |
| <a name="module_rke"></a> [rke](#module\_rke) | ../../../../modules/distribution/rke | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.wait-docker-startup-m](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.wait-docker-startup-w](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.wait-k8s-services-startup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region used for all resources | `string` | `"us-east-1"` | no |
| <a name="input_bootstrap_rancher"></a> [bootstrap\_rancher](#input\_bootstrap\_rancher) | Bootstrap the Rancher installation | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | n/a | `any` | `null` | no |
| <a name="input_create_ssh_key_pair"></a> [create\_ssh\_key\_pair](#input\_create\_ssh\_key\_pair) | n/a | `any` | `null` | no |
| <a name="input_docker_version"></a> [docker\_version](#input\_docker\_version) | Docker version to install on nodes | `string` | `"20.10"` | no |
| <a name="input_ingress_provider"></a> [ingress\_provider](#input\_ingress\_provider) | Ingress controller provider | `string` | `"nginx"` | no |
| <a name="input_install_docker"></a> [install\_docker](#input\_install\_docker) | Install Docker while creating the instances | `bool` | `true` | no |
| <a name="input_instance_security_group_id"></a> [instance\_security\_group\_id](#input\_instance\_security\_group\_id) | n/a | `any` | `null` | no |
| <a name="input_master_nodes_count"></a> [master\_nodes\_count](#input\_master\_nodes\_count) | n/a | `any` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `any` | n/a | yes |
| <a name="input_rancher_hostname"></a> [rancher\_hostname](#input\_rancher\_hostname) | n/a | `any` | n/a | yes |
| <a name="input_rancher_password"></a> [rancher\_password](#input\_rancher\_password) | n/a | `string` | n/a | yes |
| <a name="input_rancher_version"></a> [rancher\_version](#input\_rancher\_version) | Rancher version to install | `string` | `null` | no |
| <a name="input_ssh_key_pair_name"></a> [ssh\_key\_pair\_name](#input\_ssh\_key\_pair\_name) | n/a | `any` | `null` | no |
| <a name="input_ssh_private_key_path"></a> [ssh\_private\_key\_path](#input\_ssh\_private\_key\_path) | n/a | `any` | `null` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | n/a | `any` | `null` | no |
| <a name="input_ssh_username"></a> [ssh\_username](#input\_ssh\_username) | n/a | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `any` | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data content for EC2 instance(s) | `any` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | `null` | no |
| <a name="input_waiting_time"></a> [waiting\_time](#input\_waiting\_time) | Waiting time (in seconds) | `number` | `180` | no |
| <a name="input_worker_nodes_count"></a> [worker\_nodes\_count](#input\_worker\_nodes\_count) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_instances_private_ip"></a> [master\_instances\_private\_ip](#output\_master\_instances\_private\_ip) | n/a |
| <a name="output_master_instances_public_ip"></a> [master\_instances\_public\_ip](#output\_master\_instances\_public\_ip) | n/a |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | n/a |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |
| <a name="output_worker_instances_private_ip"></a> [worker\_instances\_private\_ip](#output\_worker\_instances\_private\_ip) | n/a |
| <a name="output_worker_instances_public_ip"></a> [worker\_instances\_public\_ip](#output\_worker\_instances\_public\_ip) | n/a |
