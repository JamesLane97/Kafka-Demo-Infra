variable "deployment-enviroment" {
  description = "The name of the enviroment the resources will be deployed in (Dev/Test/Prod). Used for naming and tagging resources."
  type        = string
  default     = "Dev"
}
variable "project-name" {
  description = "The name of the project will be used for resources."
  type        = string
  default     = "Kafka-Demo-Infra"
}

variable "deployment-location" {
  description = "The geological location of the projects resources."
  type        = string
  default     = "UK South"

}

variable "management-vm-size" {
  description = "The machine size for the management VM."
  type        = string
  default     = "Standard_B1s"
}

variable "DEFAULT_SSHKEY" {
  description = "The public SSH key for the management VM."
}

variable "management-nsg-inbound-rules" {
  description = "Inbound ports for the management NSG."
  type        = list(any)
  default     = ["22", "80"]
}