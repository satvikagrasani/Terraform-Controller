 # Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = { Name = "NatEIP" }
}

# NAT Gateway in one Public Subnet
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1.id
  tags = { Name = "NatGateway" }
  depends_on    = [aws_internet_gateway.igw]
}
