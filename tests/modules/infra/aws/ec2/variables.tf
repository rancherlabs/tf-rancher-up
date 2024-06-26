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
