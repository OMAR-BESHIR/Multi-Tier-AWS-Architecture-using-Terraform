provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  cidr   = var.vpc_cidr
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "nat" {
  source            = "./modules/nat"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.subnets.public_subnets
  private_subnets   = module.subnets.private_subnets
  igw_id            = module.vpc.igw_id
}

module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.subnets.public_subnets
  alb_sg          = module.security.alb_sg
  web1_id  = module.ec2.web1_id
  web2_id  = module.ec2.web2_id
}

module "ec2" {
  source            = "./modules/ec2"
  private_subnets   = module.subnets.private_subnets
  web_sg            = module.security.web_sg
}

module "rds" {
  source          = "./modules/rds"
  subnets         = module.subnets.private_subnets
  db_sg           = module.security.db_sg
}