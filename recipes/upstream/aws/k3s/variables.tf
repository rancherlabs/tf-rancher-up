variable "aws_access_key" {
  default     = null
  description = "AWS access key used to create infrastructure"
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region used for all resources"
  type        = string

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


variable "aws_secret_key" {
  default     = false
  description = "AWS secret key used to create AWS infrastructure"
  sensitive   = true
  type        = string
}

variable "create_security_group" {
  default     = false
  description = "Should create the security group associated with the instance(s)"
  type        = bool
}

variable "create_ssh_key_pair" {
  default     = false
  description = "Specify if a new SSH key pair needs to be created for the instances"
  type        = bool
}

variable "instance_disk_size" {
  default     = null
  description = "Specify root disk size (GB)"
  type        = string
}

variable "instance_security_group" {
  default     = null
  description = "Provide a pre-existing security group ID"
  type        = string
}

variable "instance_type" {
  default     = null
  description = "Instance type used for all EC2 instances"
  type        = string
}

variable "k3s_channel" {
  default     = null
  description = "K3s channel to use, the latest patch version for the provided minor version will be used"
  type        = string
}

variable "k3s_config" {
  default     = null
  description = "Additional k3s configuration to add to the config.yaml file"
  type        = string
}

variable "k3s_token" {
  default     = null
  description = "Token to use when configuring k3s nodes"
  type        = string
}

variable "k3s_version" {
  default     = null
  description = "Kubernetes version to use for the k3s cluster"
  type        = string
}

variable "kube_config_filename" {
  default     = null
  description = "Filename to write the kube config"
  type        = string
}

variable "kube_config_path" {
  default     = null
  description = "The path to write the kubeconfig for the RKE cluster"
  type        = string
}

variable "prefix" {
  default     = null
  description = "Prefix added to names of all resources"
  type        = string
}

variable "rancher_bootstrap_password" {
  default     = "initial-admin-password"
  description = "Password to use for bootstrapping Rancher (min 12 characters)"
  type        = string
}

variable "rancher_password" {
  default     = null
  description = "Password to use for Rancher (min 12 characters)"
  type        = string

  validation {
    condition     = length(var.rancher_password) >= 12
    error_message = "The password provided for Rancher (rancher_password) must be at least 12 characters"
  }
}

variable "rancher_replicas" {
  default     = 3
  description = "Value for replicas when installing the Rancher helm chart"
  type        = number
}

variable "rancher_version" {
  default     = null
  description = "Rancher version to install"
  type        = string
}

variable "server_instance_count" {
  default     = null
  description = "Number of server EC2 instances to create"
  type        = number
}

variable "ssh_key_pair_name" {
  default     = null
  description = "Specify the SSH key name to use (that's already present in AWS)"
  type        = string
}

variable "ssh_key_pair_path" {
  default     = null
  description = "Path to the SSH private key used as the key pair (that's already present in AWS)"
  type        = string
}

variable "ssh_username" {
  default     = "ubuntu"
  description = "Username used for SSH with sudo access"
  type        = string
}

variable "spot_instances" {
  default     = false
  description = "Use spot instances"
  type        = bool
}

variable "subnet_id" {
  default     = null
  description = "VPC Subnet ID to create the instance(s) in"
  type        = string
}

variable "wait" {
  default     = "20s"
  description = "An optional wait before installing the Rancher helm chart"
  type        = string
}

variable "worker_instance_count" {
  default     = null
  description = "Number of worker EC2 instances to create"
  type        = number
}

