variable "prefix" {
  default     = "rancher-terraform"
  description = "Prefix added to names of all resources"
  type        = string
}

variable "project_id" {
  default     = null
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  default     = "us-west2"
  description = "Google Region to create the resources"

  validation {
    condition = contains([
      "asia-east1",
      "asia-east2",
      "asia-northeast1",
      "asia-northeast2",
      "asia-northeast3",
      "asia-south1",
      "asia-south2",
      "asia-southeast1",
      "asia-southeast2",
      "australia-southeast1",
      "australia-southeast2",
      "europe-central2",
      "europe-north1",
      "europe-southwest1",
      "europe-west1",
      "europe-west10",
      "europe-west12",
      "europe-west2",
      "europe-west3",
      "europe-west4",
      "europe-west6",
      "europe-west8",
      "europe-west9",
      "me-central1",
      "me-central2",
      "me-west1",
      "northamerica-northeast1",
      "northamerica-northeast2",
      "southamerica-east1",
      "southamerica-west1",
      "us-central1",
      "us-east1",
      "us-east4",
      "us-east5",
      "us-south1",
      "us-west1",
      "us-west2",
      "us-west3",
      "us-west4",
    ], var.region)
    error_message = "Invalid Region specified!"
  }
}

# variable "ip_cidr_range" {}

# variable "vpc" {}

# variable "subnet" {}

# variable "cluster_version" {}

# variable "instance_count" {}

# variable "instance_disk_size" {}

# variable "disk_type" {}

# variable "image_type" {}

# variable "instance_type" {}

variable "bootstrap_rancher" {
  default     = true
  description = "Bootstrap the Rancher installation"
  type        = bool
}

variable "rancher_hostname" {
  default     = null
  description = "Hostname for Rancher server"
  type        = string
}

variable "rancher_password" {
  default     = null
  description = "Password for accessing Rancher server (minimum 12 characters)"
  type        = string

  validation {
    condition     = length(var.rancher_password) >= 12
    error_message = "The password must be at least 12 characters."
  }
}

variable "rancher_version" {
  default     = null
  description = "Rancher version to install"
  type        = string
}
