variable "prefix" {
  default = "ec2-test"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "ssh_private_key_path" {
  default = null
}

variable "instance_count" {
  default = 1
}

variable "ssh_username" {
  default = "ubuntu"
}

variable "user_data" {
  default = null
}

variable "install_docker" {
  type    = bool
  default = true
}

variable "docker_version" {
  type    = string
  default = "20.10"
}

variable "waiting_time" {
  default = 180
}

variable "ingress_provider" {
  default = "nginx"
}

variable "bootstrap_rancher" {
  type    = bool
  default = true
}

variable "rancher_hostname" {
  default = "rancher"
}

variable "rancher_password" {
  default = "at-least-12-characters"
}
