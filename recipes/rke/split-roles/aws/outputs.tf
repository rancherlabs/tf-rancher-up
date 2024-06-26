output "master_instances_public_ip" {
  value = module.aws-ec2-upstream-master-nodes.instances_public_ip
}

output "master_instances_private_ip" {
  value = module.aws-ec2-upstream-master-nodes.instances_private_ip
}

output "worker_instances_public_ip" {
  value = module.aws-ec2-upstream-worker-nodes.instances_public_ip
}

output "worker_instances_private_ip" {
  value = module.aws-ec2-upstream-worker-nodes.instances_private_ip
}

output "vpc" {
  value = module.aws-ec2-upstream-master-nodes.vpc[0].id
}

output "subnet" {
  value = module.aws-ec2-upstream-master-nodes.subnet[0].id
}

output "security_group" {
  value = module.aws-ec2-upstream-master-nodes.security_group[0].id
}
