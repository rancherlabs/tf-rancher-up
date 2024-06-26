variable "prefix" {}

variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
  default     = "us-east-1"

  validation {
    condition = contains([
      "us-east-2",
      "us-east-1",
      "us-west-1",
      "us-west-2",
      "af-south-1",
      "ap-east-1",
      "ap-south-2",
      "ap-southeast-3",
      "ap-southeast-4",
      "ap-south-1",
      "ap-northeast-3",
      "ap-northeast-2",
      "ap-southeast-1",
      "ap-southeast-2",
      "ap-northeast-1",
      "ca-central-1",
      "ca-west-1",
      "eu-central-1",
      "eu-west-1",
      "eu-west-2",
      "eu-south-1",
      "eu-west-3",
      "eu-south-2",
      "eu-north-1",
      "eu-central-2",
      "il-central-1",
      "me-south-1",
      "me-central-1",
      "sa-east-1",
    ], var.aws_region)
    error_message = "Invalid Region specified!"
  }
}

variable "create_ssh_key_pair" {
  default = null
}

variable "ssh_key_pair_name" {
  default = null
}

variable "ssh_private_key_path" {
  default = null
}

variable "ssh_public_key_path" {
  default = null
}

variable "vpc_id" {
  default = null
}

variable "subnet_id" {
  default = null
}

variable "create_security_group" {
  default = null
}

variable "master_nodes_count" {}

variable "worker_nodes_count" {}

variable "instance_security_group_id" {
  default = null
}

variable "ssh_username" {}

variable "user_data" {
  description = "User data content for EC2 instance(s)"
  default     = null
}

variable "install_docker" {
  type        = bool
  description = "Install Docker while creating the instances"
  default     = true
}

variable "docker_version" {
  type        = string
  description = "Docker version to install on nodes"
  default     = "20.10"
}

variable "waiting_time" {
  description = "Waiting time (in seconds)"
  default     = 180
}

variable "ingress_provider" {
  description = "Ingress controller provider"
  default     = "nginx"
}

variable "bootstrap_rancher" {
  description = "Bootstrap the Rancher installation"
  type        = bool
  default     = true
}

variable "rancher_hostname" {}

variable "rancher_password" {
  type = string

  validation {
    condition     = length(var.rancher_password) >= 12
    error_message = "The password must be at least 12 characters."
  }
}

variable "rancher_version" {
  description = "Rancher version to install"
  type        = string
  default     = null
}
