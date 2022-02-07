#===================================MAIN_SG==============================================
resource "aws_security_group" "mainSG" {
  name   = "Security group for all components"
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-main-SG"
  }
}
#===================================BASTION_SG==========================================
resource "aws_security_group" "bastionSG" {

  name        = "SG for bastion host"
  description = "bastion host security group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.bastion_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#===============================ALB_SG===================================================

resource "aws_security_group" "albSG" {

  name        = "ALB SG"
  description = "app load balancer security group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.alb_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
