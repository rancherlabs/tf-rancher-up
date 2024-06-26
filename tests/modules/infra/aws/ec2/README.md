# TEST - AWS EC2 instances deploy

This directory has code to test the AWS EC2 [module](../../../../../modules/infra/aws/ec2).

Documentation can be found [here](./docs.md).

## Usage

```bash
git clone https://github.com/rancherlabs/tf-rancher-up.git
cd test/modules/infra/aws/ec2
```

- Edit `./variables.tf`
  - Update the required variables:
    -  `prefix` to give the resources an identifiable name (eg, your initials or first name)
    -  `aws_region` to suit your region
    -  `instance_count` to specify the number of instances to create
    -  `ssh_username` to specify the user used to create the VMs (default "ubuntu")
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
