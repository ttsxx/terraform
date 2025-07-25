resource "aws_eip" "nat_eip" {
  for_each = var.public_subnets

  domain = "vpc"

  tags = {
    Name = "nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "nat_gws" {
  for_each = var.public_subnets

  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = each.value

  tags = {
    Name = "nat-gw-${each.key}"
  }
}