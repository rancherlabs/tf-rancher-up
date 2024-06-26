module "aws-ec2-upstream-cluster" {
  source         = "../../../../../modules/infra/aws/ec2"
  prefix         = var.prefix
  aws_region     = var.aws_region
  instance_count = var.instance_count
  ssh_username   = var.ssh_username
  user_data = templatefile("${path.module}/user_data.tmpl",
    {
      install_docker = var.install_docker
      username       = var.ssh_username
      docker_version = var.docker_version
    }
  )
}

resource "null_resource" "wait-docker-startup" {
  depends_on = [module.aws-ec2-upstream-cluster.instances_public_ip]
  provisioner "local-exec" {
    command = "sleep ${var.waiting_time}"
  }
}

locals {
  ssh_private_key_path = var.ssh_private_key_path != null ? var.ssh_private_key_path : "${path.cwd}/${var.prefix}-ssh_private_key.pem"
}

module "rke" {
  source               = "../../../../../modules/distribution/rke"
  prefix               = var.prefix
  dependency           = [resource.null_resource.wait-docker-startup]
  ssh_private_key_path = local.ssh_private_key_path
  node_username        = var.ssh_username

  rancher_nodes = [for instance_ips in module.aws-ec2-upstream-cluster.instance_ips :
    {
      public_ip         = instance_ips.public_ip,
      private_ip        = instance_ips.private_ip,
      roles             = ["etcd", "controlplane", "worker"],
      ssh_key_path      = local.ssh_private_key_path,
      ssh_key           = null,
      hostname_override = null
    }
  ]
}

resource "null_resource" "wait-k8s-services-startup" {
  depends_on = [module.rke]
  provisioner "local-exec" {
    command = "sleep ${var.waiting_time}"
  }
}

locals {
  kubeconfig_file  = "${path.cwd}/${var.prefix}_kube_config.yml"
  rancher_hostname = var.rancher_hostname != null ? join(".", ["${var.rancher_hostname}", module.aws-ec2-upstream-cluster.instances_public_ip[0], "sslip.io"]) : join(".", ["rancher", module.aws-ec2-upstream-cluster.instances_public_ip[0], "sslip.io"])

}

module "rancher_install" {
  source                     = "../../../../../modules/rancher"
  dependency                 = [null_resource.wait-k8s-services-startup]
  kubeconfig_file            = local.kubeconfig_file
  rancher_hostname           = local.rancher_hostname
  rancher_bootstrap_password = var.rancher_password
  rancher_password           = var.rancher_password
  bootstrap_rancher          = var.bootstrap_rancher
  rancher_additional_helm_values = [
    "replicas: ${var.instance_count}"
  ]
}
