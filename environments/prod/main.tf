module "defaults" {
  source = "../../global"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.env
}

module "igw" {
  source   = "../../modules/igw"
  vpc_id   = module.vpc.vpc.id
  vpc_name = module.vpc.vpc.name
}

module "subnets" {
  source   = "../../modules/subnets"
  vpc_id   = module.vpc.vpc.id
  subnets  = var.subnets
  vpc_name = module.vpc.vpc.name
}

module "natgws" {
  source         = "../../modules/nat_gws"
  public_subnets = module.subnets.public_subnets
}

module "rts" {
  source          = "../../modules/rts"
  vpc_id          = module.vpc.vpc.id
  igw_id          = module.igw.igw.id
  vpc_name        = module.vpc.vpc.name
  natgw_ids       = module.natgws.natgw_ids
  public_subnets  = module.subnets.public_subnets
  private_subnets = module.subnets.private_subnets

}

