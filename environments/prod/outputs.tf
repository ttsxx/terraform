output "vpc_id" {
  value = module.vpc.vpc.id
}

output "igw_id" {
  value = module.igw.igw.id
}

output "subnets" {
  value = module.subnets.created_subnets
}

# output "nat_gw" {
#   value = {
#     for k, m in module.natgws : k => m
#   }
# }



