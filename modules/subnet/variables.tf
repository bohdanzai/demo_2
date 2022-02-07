variable "publicSubnetCIDR" {
  type = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "privateSubnetCIDR" {
  type = list(string)
  default = ["10.0.10.0/24","10.0.20.0/24"]
}

variable "vpc_id" {}

variable "environment" {}