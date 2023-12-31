variable "app-name" {
  description = ""
  type        = string
}

variable "resource-group" {
  description = ""
  type        = string
}

variable "env-id" {
  description = ""
  type        = string

}

variable "image" {
  description = ""
  type        = string
}

variable "cpu" {
  description = ""
  type        = number
}

variable "memory" {
  description = ""
  type        = string
}

variable "commands" {
  description = ""
  type        = list(string)
}

variable "replicas-max" {
  description = ""
  type        = number
}

variable "replicas-min" {
  description = ""
  type        = number
}