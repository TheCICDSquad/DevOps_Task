resource "aws_subnet" "web_public_subnet" {
  count = length(var.public_subnets)
  
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
}