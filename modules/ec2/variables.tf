variable "publicSubnetCIDR" {}
variable "privateSubnetCIDR" {}

variable "subnet_pub_id"{}
variable "subnet_priv_id"{}

variable "vpc_security_group_ids"{}
variable "bastion_security_group_ids"{}


variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "os_image" {
    type = string
    default = "ami-03a0c45ebc70f98ea"
}