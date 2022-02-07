resource "aws_instance" "bastion" {
  count = length(var.publicSubnetCIDR)
  # image_id = "ami-03a0c45ebc70f98ea"
  ami                    = var.os_image
  instance_type          = var.instance_type
  subnet_id              = var.subnet_pub_id[count.index].id
  vpc_security_group_ids = [var.bastion_security_group_ids.id]
  tags = {
    Name = "Bastion host"
  }
}
