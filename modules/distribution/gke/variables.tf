variable "prefix" {
  description = "The prefix used in front of all Google resources"
}

variable "project_id" {
  description = "The ID of the Google Project that will contain all created resources"
}

variable "region" {
  description = "Google Region to create the resources"
  default     = "us-west2"

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

variable "ip_cidr_range" {
  type        = string
  default     = "10.10.0.0/24"
  description = "Range of private IPs available for the Google Subnet"
}

variable "vpc" {
  description = "Google VPC used for all resources"
  default     = null
}

variable "subnet" {
  description = "Google Subnet used for all resources"
  default     = null
}

variable "cluster_version_prefix" {
  default     = "1.28."
  description = "Supported Google Kubernetes Engine for Rancher Manager"
}

variable "instance_count" {
  default     = 1
  description = "The number of nodes per instance group"
}

variable "instance_disk_size" {
  default     = 50
  description = "Size of the disk attached to each node, specified in GB"
}

variable "disk_type" {
  default     = "pd-balanced"
  description = "Type of the disk attached to each node (e.g. 'pd-standard', 'pd-ssd' or 'pd-balanced')"
}

variable "image_type" {
  default     = "cos_containerd"
  description = "The default image type used by NAP once a new node pool is being created. The value must be one of the [COS_CONTAINERD, COS, UBUNTU_CONTAINERD, UBUNTU]. NOTE: COS AND UBUNTU are deprecated as of GKE 1.24"
}

variable "instance_type" {
  default     = "e2-highmem-2"
  description = "The name of a Google Compute Engine machine type"
}

variable "kube_config_path" {
  description = "The path to write the kubeconfig for the RKE cluster"
  type        = string
  default     = null
}

variable "kube_config_filename" {
  description = "Filename to write the kube config"
  type        = string
  default     = null
}
