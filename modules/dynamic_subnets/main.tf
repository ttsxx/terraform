locals {
  public_subnets = {
    for i, az in var.azs :
    az => cidrsubnet(var.vpc_cidr, 8, i)
  }

  private_subnets = {
    for i, az in var.azs :
    az => cidrsubnet(var.vpc_cidr, 8, i + length(var.azs))
  }
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.name}-${each.key}-public"
  }
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.name}-${each.key}-private"
  }
}