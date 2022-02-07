provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source      = "./modules/subnet"
  vpc_id      = module.vpc.vpc_id
  environment = module.vpc.environment
}

module "sg" {
  source      = "./modules/sg"
  vpc_id      = module.vpc.vpc_id
  environment = module.vpc.environment
}

module "gateway" {
  source            = "./modules/gateway"
  vpc_id            = module.vpc.vpc_id
  publicSubnetCIDR  = module.subnet.publicSubnetCIDR
  privateSubnetCIDR = module.subnet.privateSubnetCIDR
  subnet_pub_id     = module.subnet.subnet_pub_id
  subnet_priv_id    = module.subnet.subnet_priv_id
  environment       = module.vpc.environment
}

module "ec2" {
  source                     = "./modules/ec2"
  publicSubnetCIDR           = module.subnet.publicSubnetCIDR
  privateSubnetCIDR          = module.subnet.privateSubnetCIDR
  subnet_pub_id              = module.subnet.subnet_pub_id
  subnet_priv_id             = module.subnet.subnet_priv_id
  vpc_security_group_ids     = module.sg.vpc_security_group_ids
  bastion_security_group_ids = module.sg.bastion_security_group_ids
}

module "ballancer" {
  source                 = "./modules/ballancer"
  subnet_pub_id          = module.subnet.subnet_pub_id
  subnet_priv_id         = module.subnet.subnet_priv_id
  alb_security_group_ids = module.sg.alb_security_group_ids
  environment            = module.vpc.environment
  vpc_id = module.vpc.vpc_id
}

module "autoscaling" {
  source                 = "./modules/autoscaling"
  alb_target             = module.ballancer.alb_target
  os_image               = module.ec2.os_image
  subnet_priv_id         = module.subnet.subnet_priv_id
  vpc_security_group_ids = module.sg.vpc_security_group_ids
  environment            = module.vpc.environment
  vpc_id                 = module.vpc.vpc_id
}