output "instances_public_ip" {
  value = module.aws-ec2-upstream-cluster.instances_public_ip
}

output "instances_private_ip" {
  value = module.aws-ec2-upstream-cluster.instances_private_ip
}

output "rancher_url" {
  description = "Rancher URL"
  value       = "https://${module.rancher_install.rancher_hostname}"
}

output "rancher_password" {
  description = "Rancher Initial Custom Password"
  value       = var.rancher_password
}
