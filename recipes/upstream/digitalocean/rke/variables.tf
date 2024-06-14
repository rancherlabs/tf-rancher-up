variable "do_token" {
  default     = null
  description = "DigitalOcean Authentication Token"
  sensitive   = true
  type        = string
}

variable "droplet_count" {
  default     = 3
  description = "Number of droplets to create"
  nullable    = false
  type        = number
}

variable "droplet_size" {
  default     = "s-2vcpu-4gb"
  description = "Size used for all droplets"
  nullable    = false
  type        = string

}

variable "prefix" {
  default     = "rancher-terraform"
  description = "Prefix added to names of all resources"
  type        = string
}

variable "tag_begin" {
  default     = 1
  description = "Tag from this number when module is called more than once"
  type        = number
}

variable "user_tag" {
  default     = 1
  description = "FirstInitialLastname of user"
  nullable    = false
  type        = string
}

variable "create_ssh_key_pair" {
  default     = false
  description = "Specify if a new SSH key pair needs to be created for the instances"
  nullable    = false
  type        = bool
}

variable "ssh_key_pair_name" {
  default     = null
  description = "Specify the SSH key name to use (that's already present in DigitalOcean)"
  type        = string
}

variable "ssh_key_pair_path" {
  default     = null
  description = "Path to the SSH private key used as the key pair (that's already present in DigitalOcean)"
  type        = string
}

variable "ssh_private_key_path" {
  default     = null
  description = "Path to write the generated SSH private key"
  type        = string
}

variable "region" {
  default     = "sfo3"
  description = "Region that droplets will be deployed to"
  type        = string

  validation {
    condition = contains([
      "nyc1",
      "nyc3",
      "ams3",
      "sfo2",
      "sfo3",
      "sgp1",
      "lon1",
      "fra1",
      "tor1",
      "blr1",
      "syd1",
    ], var.region)
    error_message = "Invalid Region specified!"
  }
}

variable "ssh_username" {
  default     = "root"
  description = "The user account used to connect to droplets via ssh"
  nullable    = false
  type        = string
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

variable "rancher_password" {
  default     = "initial-admin-password"
  description = "Password to use for bootstrapping Rancher (min 12 characters)"
  type        = string
}

variable "rancher_version" {
  default     = null
  description = "Rancher version to install"
  type        = string
}

variable "wait" {
  description = "An optional wait before installing the Rancher helm chart"
  default     = "20s"
  type        = string
}
