data "aws_availability_zones" "available" {
    state = "available"
}

locals {
  flattened_subnets = flatten([
    for purpose, config in var.subnets : [
      for i, cidr in config.cidrs : {
        key  = "${purpose}-${i}"
        cidr = cidr
        type = config.type
        purpose = purpose
      }
    ]
  ])

  subnet_map = {
    for subnet in local.flattened_subnets : subnet.key => {
      cidr    = subnet.cidr
      type    = subnet.type      # public or private
      purpose = subnet.purpose   # web, app, db
    }
  }

  sorted_keys = sort(keys(local.subnet_map))
}
 
resource "aws_subnet" "all-subnets" {
  for_each          = local.subnet_map
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = data.aws_availability_zones.available.names[
    index(local.sorted_keys, each.key) % length(data.aws_availability_zones.available.names)
  ]

  tags = {
    Name     = "${each.key}-${var.vpc_name}"
    Type     = each.value.type      # public or private
    Purpose  = each.value.purpose   # web, app, db
  }
}