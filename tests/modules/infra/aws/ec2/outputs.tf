output "instances_public_ip" {
  value = module.aws-ec2-upstream-cluster.instances_public_ip
}

output "instances_private_ip" {
  value = module.aws-ec2-upstream-cluster.instances_private_ip
}
