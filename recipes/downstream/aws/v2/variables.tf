variable "cluster_name" {
  default     = "v2-ds"
  description = "The cluster name"
  type        = string
}

variable "rancher_token" {
  default     = null
  description = "Rancher API token"
  type        = string
}

variable "rancher_insecure" {
  default     = true
  description = "Allow insecure connections to Rancher"
  type        = bool
}

variable "rancher_url" {
  default     = null
  description = "The Rancher server URL"
  type        = string
}

variable "aws_access_key" {
  default     = null
  description = "AWS access key used to create infrastructure"
  type        = string
}

variable "aws_secret_key" {
  default     = null
  description = "AWS secret key used to create AWS infrastructure"
  sensitive   = true
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
}

variable "zone" {
  default     = "a"
  description = "AWS zone to use for all resources"
  type        = string
}

variable "cloud_credential_id" {
  default     = null
  description = "Rancher cloud credential to use, instead of AWS access/secret key (ex: cattle-global-data:cc-xxx)"
  type        = string
}

variable "subnet_id" {
  default     = null
  description = "Subnet ID for all resources"
  type        = string
}

variable "cp_count" {
  default     = 1
  description = "Control plane pool node count"
  type        = number
}

variable "worker_count" {
  default     = 1
  description = "Worker pool node count"
  type        = number
}

variable "kubernetes_version" {
  default     = null
  description = "Kubernetes version to use for the RKE2/k3s cluster"
  type        = string
}

variable "cp_node_pool_name" {
  default     = "cp"
  description = "Control plane pool name"
  type        = string
}

variable "worker_node_pool_name" {
  default     = "w"
  description = "Worker pool name"
  type        = string
}

variable "instance_type" {
  default     = "t3a.medium"
  description = "Instance type used for all EC2 instances"
  type        = string
}

variable "volume_size" {
  default     = 20
  description = "Specify root volume size (GB)"
  type        = number
}

variable "cni_provider" {
  default     = "calico"
  description = "CNI provider to use"
  type        = string
}

variable "vpc_id" {
  default     = null
  description = "AWS VPC to use, subnet ID and security group must exist in the VPC"
  type        = string
}

variable "security_group_name" {
  default     = null
  description = "Security Group name for nodes"
  type        = string
}

variable "ssh_user" {
  default     = "ubuntu"
  description = "Username used for SSH with sudo access"
  type        = string
}

variable "spot_instances" {
  default     = bool
  description = "Use spot instances"
  type        = bool
}

variable "ami" {
  default     = null
  description = "AMI to use when launching nodes"
  type        = string

  validation {
    condition     = can(regex("^ami-[[:alnum:]]{10}", var.ami))
    error_message = "The ami value must be a valid AMI id, starting with \"ami-\"."
  }
}
