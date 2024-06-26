locals {
  kc_path        = var.kube_config_path != null ? var.kube_config_path : path.cwd
  kc_file        = var.kube_config_filename != null ? "${local.kc_path}/${var.kube_config_filename}" : "${local.kc_path}/${var.prefix}_kube_config.yml"
  kc_file_backup = "${local.kc_file}.backup"
}

module "k3s_first" {
  source      = "../../../../modules/distribution/k3s"
  k3s_token   = var.k3s_token
  k3s_version = var.k3s_version
  k3s_channel = var.k3s_channel
  k3s_config  = var.k3s_config
}

module "k3s_first_server" {
  source                  = "../../../../modules/infra/aws"
  prefix                  = var.prefix
  instance_count          = 1
  instance_type           = var.instance_type
  instance_disk_size      = var.instance_disk_size
  create_ssh_key_pair     = var.create_ssh_key_pair
  ssh_key_pair_name       = var.ssh_key_pair_name
  ssh_key_pair_path       = var.ssh_key_pair_path
  ssh_username            = var.ssh_username
  spot_instances          = var.spot_instances
  aws_region              = var.aws_region
  create_security_group   = var.create_security_group
  instance_security_group = var.instance_security_group
  subnet_id               = var.subnet_id
  user_data               = module.k3s_first.k3s_server_user_data
}

module "k3s_additional" {
  source          = "../../../../modules/distribution/k3s"
  k3s_token       = module.k3s_first.k3s_token
  k3s_version     = var.k3s_version
  k3s_channel     = var.k3s_channel
  k3s_config      = var.k3s_config
  first_server_ip = module.k3s_first_server.instances_private_ip[0]
}

module "k3s_additional_servers" {
  source                  = "../../../../modules/infra/aws"
  prefix                  = var.prefix
  instance_count          = var.server_instance_count - 1
  instance_type           = var.instance_type
  instance_disk_size      = var.instance_disk_size
  create_ssh_key_pair     = false
  ssh_key_pair_name       = module.k3s_first_server.ssh_key_pair_name
  ssh_key_pair_path       = pathexpand(module.k3s_first_server.ssh_key_path)
  ssh_username            = var.ssh_username
  spot_instances          = var.spot_instances
  tag_begin               = 2
  aws_region              = var.aws_region
  create_security_group   = false
  instance_security_group = module.k3s_first_server.sg-id
  subnet_id               = var.subnet_id
  user_data               = module.k3s_additional.k3s_server_user_data
}


module "k3s_workers" {
  source                  = "../../../../modules/infra/aws"
  prefix                  = var.prefix
  instance_count          = var.worker_instance_count
  instance_type           = var.instance_type
  instance_disk_size      = var.instance_disk_size
  create_ssh_key_pair     = false
  ssh_key_pair_name       = module.k3s_first_server.ssh_key_pair_name
  ssh_key_pair_path       = pathexpand(module.k3s_first_server.ssh_key_path)
  ssh_username            = var.ssh_username
  spot_instances          = var.spot_instances
  aws_region              = var.aws_region
  create_security_group   = false
  instance_security_group = module.k3s_first_server.sg-id
  subnet_id               = var.subnet_id
  user_data               = module.k3s_additional.k3s_worker_user_data
}


data "local_file" "ssh_private_key" {
  depends_on = [module.k3s_first_server]
  filename   = pathexpand(module.k3s_first_server.ssh_key_path)
}

resource "ssh_resource" "retrieve_kubeconfig" {
  host = module.k3s_first_server.instances_public_ip[0]
  commands = [
    "sudo sed 's/127.0.0.1/${module.k3s_first_server.instances_public_ip[0]}/g' /etc/rancher/k3s/k3s.yaml"
  ]
  user        = var.ssh_username
  private_key = data.local_file.ssh_private_key.content
}

resource "local_file" "kube_config_yaml" {
  filename        = local.kc_file
  content         = ssh_resource.retrieve_kubeconfig.result
  file_permission = "0600"
}

resource "local_file" "kube_config_yaml_backup" {
  filename        = local.kc_file_backup
  content         = ssh_resource.retrieve_kubeconfig.result
  file_permission = "0600"
}

locals {
  rancher_hostname = join(".", ["rancher", module.k3s_first_server.instances_public_ip[0], "sslip.io"])
}

module "rancher_install" {
  source                     = "../../../../modules/rancher"
  dependency                 = var.server_instance_count > 1 ? module.k3s_additional_servers.dependency : module.k3s_first_server.dependency
  kubeconfig_file            = local_file.kube_config_yaml.filename
  rancher_hostname           = local.rancher_hostname
  rancher_replicas           = min(var.rancher_replicas, var.server_instance_count)
  rancher_bootstrap_password = var.rancher_bootstrap_password
  rancher_password           = var.rancher_password
  rancher_version            = var.rancher_version
  wait                       = var.wait
}
