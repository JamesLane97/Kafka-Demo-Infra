variable "vm-name" {
  description = "The name for the VM."
  type        = string
}

variable "vm-resource-group" {
  description = "The resource group which the VM will belong to."
  type        = string
}

variable "vm-location" {
  description = "Location for the VM."
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

variable "vm-subnet-id" {
  description = "value"
  type        = string
}