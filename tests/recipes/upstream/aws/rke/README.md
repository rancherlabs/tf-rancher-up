# Upstream | AWS | EC2 x RKE

This directory contains the code for testing the AWS EC2 x RKE x Rancher modules.

Documentation can be found [here](./docs.md).

## Usage

```bash
git clone https://github.com/rancherlabs/tf-rancher-up.git
cd tests/recipes/upstream/aws/rke
```

- Edit `./variables.tf`
  - Update the required variables (`prefix`, `aws_region`, `ssh_private_key_path`, `instance_count`, `ssh_username`, `user_data`, `install_docker`, `docker_version`, `waiting_time`, `ingress_provider`, `bootstrap_rancher`, `rancher_hostname`, and `rancher_password`).
- Make sure you are logged into your AWS Account from your local Terminal. See the preparatory steps [here](../../../../../modules/infra/aws/README.md).

```bash
terraform init --upgrade ; terraform apply --auto-approve
```

- Destroy the resources when finished
```bash
terraform destroy --auto-approve

```

See full argument list for each module in use:
  - AWS EC2: https://github.com/rancher/tf-rancher-up/tree/main/modules/infra/aws/ec2
  - RKE: https://github.com/rancher/tf-rancher-up/tree/main/modules/distribution/rke
  - Rancher: https://github.com/rancher/tf-rancher-up/tree/main/modules/rancher
