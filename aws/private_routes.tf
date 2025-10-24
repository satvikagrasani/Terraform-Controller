# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "PrivateRouteTable" }
}

# Route Private Subnets via NAT Gateway
resource "aws_route" "private_nat_access" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw.id
}

# Associate Private Subnets
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt.id
}
