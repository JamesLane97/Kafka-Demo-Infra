variable "vm-name" {
  description = "The name for the VM."
  type        = string
}

variable "resource-group" {
  description = "The resource group which the VM will belong to."
  type        = string
}

variable "deploy-location" {
  description = "The geological location for the VM."
  type        = string
}

variable "vm-public-key" {
  description = "Public key for SSH."
  type        = string
}

variable "vm-size" {
  description = "The machine size for the VM."
  type        = string

}

variable "subnet-id" {
  description = "The ID of the subnet the VMs NIC will be associated with."
  type        = string
}