#=============================== Internet gateway ==================================

resource "aws_internet_gateway" "internetgateway" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.environment}-InternetGateway"
  }
}

resource "aws_route_table" "publicroutetable" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internetgateway.id
  }
  depends_on = [aws_internet_gateway.internetgateway]
}

resource "aws_route_table_association" "routeTableAssociationPublicRoute" {
  count          = length(var.publicSubnetCIDR)
  route_table_id = aws_route_table.publicroutetable.id
  subnet_id      = var.subnet_pub_id[count.index].id
}

#=============================== NAT gateway ========================================
resource "aws_eip" "nat_eip" {
  count = length(var.publicSubnetCIDR)

}
resource "aws_nat_gateway" "nat-gateway" {
  count         = length(var.publicSubnetCIDR)
  subnet_id     = var.subnet_pub_id[count.index].id
  allocation_id = aws_eip.nat_eip[count.index].id
}

resource "aws_route_table" "nat_routetable" {
  vpc_id = var.vpc_id
  count  = length(var.publicSubnetCIDR)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway[count.index].id
  }
  depends_on = [aws_nat_gateway.nat-gateway]
}
resource "aws_route_table_association" "nat_routeTableAssociation" {
  count          = length(var.privateSubnetCIDR)
  route_table_id = aws_route_table.nat_routetable[count.index].id
  subnet_id      = var.subnet_priv_id[count.index].id
}
