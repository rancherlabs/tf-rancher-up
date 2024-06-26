module "aws-ec2-upstream-cluster" {
  source         = "../../../../../modules/infra/aws/ec2"
  prefix         = var.prefix
  aws_region     = var.aws_region
  instance_count = var.instance_count
  ssh_username   = var.ssh_username
}
