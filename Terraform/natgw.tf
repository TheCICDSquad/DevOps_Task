resource "aws_nat_gateway" "web_nat_gateway" {
  count = 3
  
  allocation_id = aws_eip.web_nat_eip[count.index].id
  subnet_id     = aws_subnet.web_public_subnet[count.index].id
}