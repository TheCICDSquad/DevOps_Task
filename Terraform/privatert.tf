resource "aws_route_table" "web_private_route_table" {
  count = 3
  
  vpc_id = aws_vpc.web_vpc.id
}

resource "aws_route" "web_private_route" {
  count = 3
  
  route_table_id         = aws_route_table.web_private_route_table[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.web_nat_gateway[count.index].id
}