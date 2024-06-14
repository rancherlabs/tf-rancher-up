variable "aws_access_key" {
  default     = null
  description = "Enter your AWS access key"
  type        = string
}

variable "aws_secret_key" {
  default     = null
  description = "Enter your AWS secret key"
  sensitive   = true
  type        = string
}

variable "aws_region" {
  default     = "us-west-2"
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

variable "vpc_zone" {
  default     = null
  description = "VPC zone"
  type        = string
}

variable "subnet_id" {
  default     = null
  description = "VPC Subnet ID to create the instance(s) in"
  type        = string
}

variable "vpc_id" {
  default     = null
  description = "VPC ID to create the instance(s) in"
  type        = string
}

variable "create_security_group" {
  default     = true
  description = "Should create the security group associated with the instance(s)"
  type        = bool
}

# TODO: Add a check based on above value
variable "instance_security_group" {
  default     = null
  description = "Provide a pre-existing security group ID"
  type        = string
}

variable "instance_security_group_name" {
  default     = null
  description = "Provide a pre-existing security group name"
  type        = string
}

variable "prefix" {
  default     = null
  description = "Prefix added to names of all resources"
  type        = string
}

variable "master_nodes_count" {
  default     = 1
  description = "Number of master nodes to create"
  type        = number
}

variable "worker_nodes_count" {
  default     = 1
  description = "Number of worker nodes to create"
  type        = number
}

variable "kube_config_path" {
  default     = null
  description = "The path to write the kubeconfig for the RKE cluster"
  type        = string
}

variable "kube_config_filename" {
  default     = null
  description = "Filename to write the kube config"
  type        = string
}

variable "kubernetes_version" {
  default     = null
  description = "Kubernetes version to use for the RKE cluster"
  type        = string
}

variable "install_docker" {
  default     = true
  description = "Should install docker while creating the instance"
  type        = bool
}

variable "docker_version" {
  default     = "23.0.6"
  description = "Docker version to install on nodes"
  type        = string
}

variable "create_ssh_key_pair" {
  default     = false
  description = "Specify if a new SSH key pair needs to be created for the instances"
  type        = bool
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

variable "ssh_key" {
  default     = null
  description = "Contents of the private key to connect to the instances."
  sensitive   = true
  type        = string
}

variable "bastion_host" {
  default     = null
  description = "Bastion host configuration to access the RKE nodes"

  type = object({
    address      = string
    user         = string
    ssh_key_path = string
    ssh_key      = string
  })
}

variable "ssh_username" {
  default     = "ubuntu"
  description = "Username used for SSH with sudo access"
  type        = string
}

variable "master_nodes_instance_type" {
  default     = "t3.medium"
  description = "Instance type used for all master nodes"
  type        = string
}

variable "master_nodes_instance_disk_size" {
  default     = "80"
  description = "Disk size used for all master nodes (in GB)"
  type        = string
}

variable "worker_nodes_instance_type" {
  default     = "t3.large"
  description = "Instance type used for all worker nodes"
  type        = string
}

variable "worker_nodes_instance_disk_size" {
  default     = "80"
  description = "Disk size used for all worker nodes (in GB)"
  type        = string
}

variable "dependency" {
  default     = null
  description = "An optional variable to add a dependency from another resource (not used)"
  type        = bool
}

variable "master_nodes_iam_instance_profile" {
  default     = null
  description = "Specify IAM instance profile to attach to master nodes"
  type        = string
}

variable "worker_nodes_iam_instance_profile" {
  default     = null
  description = "Specify IAM instance profile to attach to worker nodes"
  type        = string
}

variable "tags" {
  default     = {}
  description = "User-provided tags for the resources"
  type        = map(string)
}

variable "cloud_provider" {
  default     = null
  description = "Specify the cloud provider name"
  type        = string
}

variable "create_kubeconfig_file" {
  default     = true
  description = "Boolean flag to generate a kubeconfig file (mostly used for dev only)"
  type        = bool
}
