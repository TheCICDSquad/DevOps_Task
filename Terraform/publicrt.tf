resource "aws_route_table" "web_public_route_table" {
  vpc_id = aws_vpc.web_vpc.id
}


resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.web_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_internet_gateway.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnets)
  subnet_id      = aws_subnet.web_public_subnet[count.index].id
  route_table_id = aws_route_table.web_public_route_table.id
}