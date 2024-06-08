# Upstream | Google Cloud | Compute Engine x RKE2

This module is used to establish a Rancher (local) managment cluster using [Google Compute Engine](https://cloud.google.com/compute?hl=en) and [RKE2](https://docs.rke2.io/).

## Usage

```bash
git clone https://github.com/rancherlabs/tf-rancher-up.git
cd recipes/upstream/google-cloud/rke2
```

- Copy `./terraform.tfvars.exmaple` to `./terraform.tfvars`
- Edit `./terraform.tfvars`
  - Update the required variables:
    -  `prefix` to give the resources an identifiable name (eg, your initials or first name)
    -  `project_id` to specify in which Project the resources will be created
    -  `region` to suit your region
    -  `server_instance_count` to specify the number of Server instances to create (to maintain ETCD quorum, the value must be 1, 3, or 5)
    -  `worker_instance_count` to specify the number of Worker instances to create
    -  `ssh_username` to specify the user used to create the VMs (default "ubuntu")
    -  `rancher_hostname` in order to reach the Rancher console via DNS name
    -  `rancher_password` to configure the initial Admin password (the password must be at least 12 characters)
- Make sure you are logged into your Google Account from your local Terminal. See the preparatory steps [here](../../../../modules/infra/google-cloud/README.md).

**NB: If you want to use all the configurable variables in the `terraform.tfvars` file, you will need to uncomment them there and in the `variables.tf` and `main.tf` files.**

```bash
terraform init -upgrade ; terraform apply -target=module.rke2-first-server.tls_private_key.ssh_private_key -target=module.rke2-first-server.local_file.private_key_pem -target=module.rke2-first-server.local_file.public_key_pem -auto-approve ; terraform apply -auto-approve ; terraform apply -target=module.rancher_install -auto-approve
```

- Destroy the resources when finished
```bash
terraform state rm module.rancher_install ; terraform destroy -auto-approve
```

See full argument list for each module in use:
  - Google Compute Engine: https://github.com/rancherlabs/tf-rancher-up/tree/main/modules/infra/google-cloud/compute-engine
  - RKE2: https://github.com/rancherlabs/tf-rancher-up/tree/main/modules/distribution/rke2
  - Rancher: https://github.com/rancherlabs/tf-rancher-up/tree/main/modules/rancher
