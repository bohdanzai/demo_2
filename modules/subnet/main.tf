data "aws_availability_zones" "availableAZ" {}

#=============================== Public subnet ==========================================
resource "aws_subnet" "publicsubnet" {
  count                   = length(var.publicSubnetCIDR)
  cidr_block              = tolist(var.publicSubnetCIDR)[count.index]
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availableAZ.names[count.index]
  tags = {
    name        = "${var.environment}-publicsubnet-${count.index + 1}"
    AZ          = data.aws_availability_zones.availableAZ.names[count.index]
    Environment = "${var.environment}-publicsubnet"
  }
}

#=============================== Private subnet =========================================
resource "aws_subnet" "privatesubnet" {
  count                   = length(var.privateSubnetCIDR)
  cidr_block              = tolist(var.privateSubnetCIDR)[count.index]
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.availableAZ.names[count.index]
  tags = {
    name        = "${var.environment}-privatesubnet-${count.index + 1}"
    AZ          = data.aws_availability_zones.availableAZ.names[count.index]
    Environment = "${var.environment}-privatesubnet"
  }
}
