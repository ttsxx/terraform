module "vpc" {
  source = "../../modules/vpc"
  name   = var.env
  cidrs  = var.vpc_cidrs
  count  = length(var.vpc_cidrs)
}

module "subnets" {
  source                = "../../modules/subnets"
  name                  = var.env
  vpc_id                = module.vpc.ids[0] # example uses first VPC
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}

module "igw" {
  source = "../../modules/igw"
  name   = var.env
  vpc_id = module.vpc.ids[0]
}

module "natgw" {
  source            = "../../modules/nat_gateway"
  name              = var.env
  public_subnet_ids = { for k, s in module.subnets.public : k => s.id }
}

module "route_tables" {
  source             = "../../modules/route_tables"
  name               = var.env
  vpc_id             = module.vpc.ids[0]
  igw_id             = module.igw.id
  natgw_ids          = module.natgw.natgw_ids
  public_subnet_ids  = { for k, s in module.subnets.public : k => s.id }
  private_subnet_ids = { for k, s in module.subnets.private : k => s.id }
}