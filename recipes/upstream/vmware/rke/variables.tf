variable "instance_count" {
  default     = 3
  description = "Number of instances to create"
  type        = number
}

variable "ssh_private_key_path" {
  default     = null
  description = "Add your SSH private key path here."
  type        = string
}

variable "vsphere_datacenter" {
  default     = null
  description = "vSphere Datacenter details."
  type        = string
}

variable "vsphere_datastore" {
  default     = null
  description = "Datastore used for storing VM data."
  type        = string
}

variable "vsphere_network" {
  default     = null
  description = "Network to which the VM is connected."
  type        = string
}

variable "vsphere_password" {
  default     = null
  description = "Add your vSphere password for the above-mentioned username."
  type        = string
  sensitive   = true
}

variable "vsphere_resource_pool" {
  default     = null
  description = "Available resource pool on the host."
  type        = string
}

variable "vsphere_server" {
  default     = null
  description = "Add the vSphere hostname."
  type        = string
}

variable "vsphere_server_allow_unverified_ssl" {
  default     = null
  description = "Allow use of unverified SSL certificates (Ex: Self signed)"
  type        = bool
}

variable "vsphere_user" {
  default     = null
  description = "Add your vSphere username."
  type        = string
}

variable "vsphere_virtual_machine" {
  default     = null
  description = "Virtual Machine template name"
  type        = string
}

