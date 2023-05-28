variable "deployment-enviroment" {
  description = "The name of the enviroment the resources will be deployed in (Dev/Test/Prod). Used for naming and tagging resources."
  type        = string
  default     = "Dev"
}
variable "project-name" {
  description = "The name of the project will be used for resources."
  type        = string
  default     = "Aker-Demo"
}

variable "deployment-location" {
  description = "The geological location of the projects resources"
  type        = string
  default     = "UK South"

}