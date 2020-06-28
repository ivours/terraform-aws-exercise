resource "aws_eip" "nat_gateway" {
  count = length(var.availability_zones)
  vpc = true
}

resource "aws_nat_gateway" "main" {
  count = length(var.availability_zones)
  allocation_id = aws_eip.nat_gateway[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
}
