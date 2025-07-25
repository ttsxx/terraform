output "created_subnets" {
  value = {
    for k, subnet in aws_subnet.all-subnets : k => {
      id     = subnet.id
      cidr   = subnet.cidr_block
      az     = subnet.availability_zone
      type   = local.subnet_map[k].type
      purpose = local.subnet_map[k].purpose
    }
  }
}

output "public_subnets" {
  value = {
    for k, subnet in aws_subnet.all-subnets :
    k => subnet.id
    if local.subnet_map[k].type == "public"
  }
}


output "private_subnets" {
  value = {
    for k, subnet in aws_subnet.all-subnets :
    k => {
      id     = subnet.id
      cidr   = subnet.cidr_block
      az     = subnet.availability_zone
      type   = local.subnet_map[k].type
      purpose = local.subnet_map[k].purpose
    } if local.subnet_map[k].type == "private"
  }
}