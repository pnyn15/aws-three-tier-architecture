  provider "aws" {
    region = "us-east-2"
  }

  # VPC Module
  module "vpc" {
    source                 = "D:\\Project\\modules\\vpc"
    cidr_block             = var.cidr_block
    public_subnet_cidrs    = var.public_subnet_cidrs
    private_subnet_cidrs   = var.private_subnet_cidrs
    availability_zones     = var.availability_zones
  }
  
  # Security Groups Module
  module "securitygroups" {
    source       = "D:\\Project\\modules\\securitygroups"
    vpc_id       = module.vpc.vpc_id
    extlb_port   = var.extlb_port
    webtier_port = var.webtier_port
    intlb_port   = var.intlb_port
    apptier_port = var.apptier_port
    db_port      = var.db_port
    depends_on   = [module.vpc]
  }

  # EC2 Instance Module
  module "ec2instance" {
    source                  = "D:\\Project\\modules\\ec2instance"
    public_subnets          = module.vpc.public_subnets
    private_subnets         = module.vpc.private_subnets
    ami_id                  = var.ami_id
    instance_type           = var.instance_type
    iam_role_name           = var.iam_role_name
    db_instance_class       = var.db_instance_class
    db_instance_subnetgroup = var.db_instance_subnetgroup
    username                = var.username
    password                = var.password
    key_name                = var.key_name
    apptier_sg              = module.securitygroups.apptier_sg
    web_tier_sg             = module.securitygroups.web_tier_sg
    db_sg                   = module.securitygroups.db_sg
    depends_on   = [module.vpc]
  }

  module "loadbalancer" {
    source                  =  "D:\\Project\\modules\\loadbalancer"
    vpc_id                  = module.vpc.vpc_id
    public_instance_id      = [module.ec2instance.public_instance_id]
    private_instance_id     = [module.ec2instance.private_instance_id]
    public_subnets          = module.vpc.public_subnets
    private_subnets         = module.vpc.private_subnets
    ext_lb_sg               = module.securitygroups.ext_lb_sg
    int_lb_sg               = module.securitygroups.int_lb_sg
    depends_on              = [module.vpc]
  }
