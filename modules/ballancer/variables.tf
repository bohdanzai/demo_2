variable "app_name" {
    type = string
    default = "demo2"
}

variable "app_port" {
  type = string
  default = 80
}

variable "subnet_pub_id"{}

variable "subnet_priv_id"{}

variable "alb_security_group_ids"{}

variable "environment" {}

variable "vpc_id" {}

# variable "autoscaling" {}