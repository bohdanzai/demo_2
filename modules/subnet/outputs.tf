output "publicSubnetCIDR" {
  value = var.publicSubnetCIDR
}

output "privateSubnetCIDR" {
  value = var.privateSubnetCIDR
}

output "subnet_pub_id" {
  value = aws_subnet.publicsubnet
}

output "subnet_priv_id" {
  value = aws_subnet.privatesubnet
}