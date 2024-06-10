## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.32.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_google-compute-engine"></a> [google-compute-engine](#module\_google-compute-engine) | ../../../../modules/infra/google-cloud/compute-engine | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ssh_key_pair"></a> [create\_ssh\_key\_pair](#input\_create\_ssh\_key\_pair) | n/a | `bool` | `false` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | n/a | `string` | `"3"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"gke-test"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | `"project-test"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-west2"` | no |
| <a name="input_startup_script"></a> [startup\_script](#input\_startup\_script) | n/a | `string` | `"export DEBIAN_FRONTEND=noninteractive ; curl -sSL https://releases.rancher.com/install-docker/20.10.sh | sh - ; sudo usermod -aG docker ubuntu ; newgrp docker ; sudo sysctl -w net.bridge.bridge-nf-call-iptables=1 ; sleep 180"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instances_private_ip"></a> [instances\_private\_ip](#output\_instances\_private\_ip) | Google Compute Engine Intances Private IPs |
| <a name="output_instances_public_ip"></a> [instances\_public\_ip](#output\_instances\_public\_ip) | Google Compute Engine Intances Public IPs |
