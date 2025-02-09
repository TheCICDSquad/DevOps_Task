resource "aws_subnet" "web_private_subnet" {
  count = length(var.private_subnets)
  
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
}

resource "aws_route_table_association" "web_private_subnet_association" {
  count = length(var.private_subnets)
  
  subnet_id      = aws_subnet.web_private_subnet[count.index].id
  route_table_id = aws_route_table.web_private_route_table[count.index].id
}