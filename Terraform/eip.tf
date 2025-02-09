resource "aws_eip" "web_nat_eip" {
  count = 3
}