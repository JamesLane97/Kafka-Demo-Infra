variable "nsg-name" {
  description = "The name of the NSG."
  type        = string
}

variable "resource-group" {
  description = "The resource group the NSG will belong to."
  type        = string
}

variable "deploy-location" {
  description = "The geological location for the NSG."
  type        = string
}

variable "inbound-tcp-rules" {
  description = "A list containing the inbound TCP rules."
  type        = list(any)
}