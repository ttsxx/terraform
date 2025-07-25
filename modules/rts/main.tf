resource "aws_route_table" "public-igw" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = var.igw_id
  }

  tags = {
    Name = "pub-rt-${var.vpc_name}"
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = each.value
  route_table_id = aws_route_table.public-igw.id
}

resource "aws_route_table" "private-natgw" {
  for_each = var.natgw_ids

  vpc_id = var.vpc_id

  route {
    cidr_block     = var.cidr_block
    nat_gateway_id = each.value
  }

  tags = {
    Name = "pri-rt-${var.vpc_name}"
  }
}

locals {
  private_to_natgw = {
    for idx, key in keys(var.private_subnets) :
    key => {
      subnet_id      = var.private_subnets[key].id
      nat_gateway_id = keys(var.natgw_ids)[idx % length(var.natgw_ids)]
    }
  }
}

resource "aws_route_table_association" "private" {
  for_each = local.private_to_natgw

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.private-natgw[each.value.nat_gateway_id].id
}