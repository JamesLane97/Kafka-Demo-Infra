variable "vm-name" {
  description = "The name of the VM the keys will be used with."
  type        = string
}

variable "resource-group" {
  description = "The resource group which the keys will belong to."
  type        = string
}

variable "deploy-location" {
  description = "The geological location for the keys."
  type        = string
}

variable "parent-id" {
  description = "The id of the parent resource group."
  type        = string

}
