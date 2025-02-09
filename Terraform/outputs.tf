output "vpc_id" {
  value = aws_vpc.web_vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value = aws_subnet.web_public_subnet[*].id
  description = "The Id of the public subnets"
}

output "private_subnet_ids" {
  value = aws_subnet.web_private_subnet[*].id
  description = "The ID of the private subnets"
}

output "private_subnet_ids" {
  value = aws_subnet.web_private_subnet[*].id
  description = "The Ids of the private subnets"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.web_internet_gateway.id
  description = "The ID of the Internet Gateway"
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.web_nat_gateway[*].id
  description = "IDs of the NAT Gateways"
}

output "nat_eip_ids" {
  value = aws_eip.web_nat_eip[*].id
  description = "Elastic IPs associated with the NAT Gateways"
}