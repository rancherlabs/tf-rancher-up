# Setup local variables
locals {
  vpc                  = var.vpc == null ? "${var.prefix}-vpc" : var.vpc
  subnet               = var.subnet == null ? "${var.prefix}-subnet" : var.subnet
  create_firewall      = var.create_firewall == null ? false : true
  private_ssh_key_path = fileexists("${path.cwd}/${var.prefix}-ssh_private_key.pem") ? "${path.cwd}/${var.prefix}-ssh_private_key.pem" : var.ssh_private_key_path
  public_ssh_key_path  = fileexists("${path.cwd}/${var.prefix}-ssh_public_key.pem") ? "${path.cwd}/${var.prefix}-ssh_public_key.pem" : var.ssh_public_key_path
}

# Create the config.yaml for the RKE2 primary server
module "rke2-first" {
  source       = "../../../../modules/distribution/rke2"
  rke2_token   = var.rke2_token
  rke2_version = var.rke2_version
  rke2_config  = var.rke2_config
}

# Create the first VM and install the main RKE2 server
module "rke2-first-server" {
  source     = "../../../../modules/infra/google-cloud/compute-engine"
  prefix     = var.prefix
  project_id = var.project_id
  region     = var.region
  #  create_ssh_key_pair  = var.create_ssh_key_pair
  #  ssh_private_key_path = local.private_ssh_key_path
  #  ssh_public_key_path  = local.public_ssh_key_path
  #  vpc                  = local.vpc
  #  subnet               = local.subnet
  #  create_firewall      = local.create_firewall
  instance_count = 1
  #  instance_disk_size   = var.instance_disk_size
  #  disk_type            = var.disk_type
  #  instance_type        = var.instance_type
  #  os_image             = var.os_image
  #  ssh_username         = var.ssh_username
  startup_script = module.rke2-first.rke2_server_user_data
}

# Create the config.yaml for the RKE2 additional servers
module "rke2-additional" {
  source          = "../../../../modules/distribution/rke2"
  rke2_token      = module.rke2-first.rke2_token
  rke2_version    = var.rke2_version
  rke2_config     = var.rke2_config
  first_server_ip = module.rke2-first-server.instances_private_ip[0]
}

# Create the additional VMs and install the RKE2 servers
module "rke2-additional-servers" {
  source     = "../../../../modules/infra/google-cloud/compute-engine"
  prefix     = var.prefix
  project_id = var.project_id
  region     = var.region
  #  create_ssh_key_pair  = var.create_ssh_key_pair
  ssh_private_key_path = local.private_ssh_key_path
  ssh_public_key_path  = local.public_ssh_key_path
  vpc                  = local.vpc
  subnet               = local.subnet
  create_firewall      = local.create_firewall
  instance_count       = var.server_instance_count - 1
  #  instance_disk_size   = var.instance_disk_size
  #  disk_type            = var.disk_type
  #  instance_type        = var.instance_type
  #  os_image             = var.os_image
  #  ssh_username         = var.ssh_username
  startup_script = module.rke2-additional.rke2_server_user_data
}

# Create the additional VMs and install the RKE2 workers
module "rke2-additional-workers" {
  source     = "../../../../modules/infra/google-cloud/compute-engine"
  prefix     = var.prefix
  project_id = var.project_id
  region     = var.region
  #  create_ssh_key_pair  = var.create_ssh_key_pair
  ssh_private_key_path = local.private_ssh_key_path
  ssh_public_key_path  = local.public_ssh_key_path
  vpc                  = local.vpc
  subnet               = local.subnet
  create_firewall      = local.create_firewall
  instance_count       = var.worker_instance_count
  #  instance_disk_size   = var.instance_disk_size
  #  disk_type            = var.disk_type
  #  instance_type        = var.instance_type
  #  os_image             = var.os_image
  #  ssh_username         = var.ssh_username
  startup_script = module.rke2-additional.rke2_worker_user_data
}

# Save the private SSH key in the Terraform data source for later use
data "local_file" "ssh-private-key" {
  depends_on = [module.rke2-additional-workers]
  filename   = local.private_ssh_key_path
}

# Export the KUBECONFIG file from the primary RKE2 node locally
locals {
  kc_path        = var.kube_config_path != null ? var.kube_config_path : path.cwd
  kc_file        = var.kube_config_filename != null ? "${local.kc_path}/${var.kube_config_filename}" : "${local.kc_path}/${var.prefix}_kube_config.yml"
  kc_file_backup = "${local.kc_file}.backup"
}

resource "ssh_resource" "retrieve-kubeconfig" {
  host = module.rke2-first-server.instances_public_ip[0]
  commands = [
    "sudo sed 's/127.0.0.1/${module.rke2-first-server.instances_public_ip[0]}/g' /etc/rancher/rke2/rke2.yaml"
  ]
  user        = var.ssh_username
  private_key = data.local_file.ssh-private-key.content
  retry_delay = "60s"
}

resource "local_file" "kube-config-yaml" {
  filename        = local.kc_file
  file_permission = "0600"
  content         = ssh_resource.retrieve-kubeconfig.result
}

resource "local_file" "kube-config-yaml-backup" {
  filename        = local.kc_file_backup
  file_permission = "0600"
  content         = ssh_resource.retrieve-kubeconfig.result
}

# Wait for the RKE2 services startup 
resource "null_resource" "wait-k8s-services-startup" {
  depends_on = [local_file.kube-config-yaml]
  provisioner "local-exec" {
    command = "sleep ${var.waiting_time}"
  }
}

# Install Rancher on the RKE2 cluster
locals {
  rancher_hostname = var.rancher_hostname != null ? join(".", ["${var.rancher_hostname}", module.rke2-first-server.instances_public_ip[0], "sslip.io"]) : join(".", ["rancher", module.rke2-first-server.instances_public_ip[0], "sslip.io"])
}

module "rancher_install" {
  source                     = "../../../../modules/rancher"
  dependency                 = [null_resource.wait-k8s-services-startup]
  kubeconfig_file            = local.kc_file
  rancher_hostname           = local.rancher_hostname
  rancher_bootstrap_password = var.rancher_password
  rancher_password           = var.rancher_password
  bootstrap_rancher          = var.bootstrap_rancher
  rancher_version            = var.rancher_version
  rancher_additional_helm_values = [
    "replicas: ${var.worker_instance_count}",
    "ingress.ingressClassName: ${var.rancher_ingress_class_name}",
    "service.type: ${var.rancher_service_type}"
  ]
}
