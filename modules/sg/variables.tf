variable "allowed_ports" {
  description = "List of allowed ports"
  type = list(any)
  default = ["80","8080","443","22"]
}

variable "bastion_ports" {
  description = "List of allowed ports"
  type = list(any)
  default = ["22"]
}

variable "alb_ports" {
  description = "List of allowed ports"
  type = list(any)
  default = ["80"]
}

variable "vpc_id" {}

variable "environment" {}