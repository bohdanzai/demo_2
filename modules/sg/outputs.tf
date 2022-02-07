output "vpc_security_group_ids" {
  value = aws_security_group.mainSG
}

output "bastion_security_group_ids" {
  value = aws_security_group.bastionSG
}

output "alb_security_group_ids" {
  value = aws_security_group.albSG
}