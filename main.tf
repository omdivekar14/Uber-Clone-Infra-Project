########################################
# Root: wire modules together
########################################
locals {
  name = var.project_name
}

# VPC module — creates VPC + public/private subnets + NAT per AZ
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  az_count     = var.az_count
}

# Security module — creates SGs for ALB, app, RDS
module "security" {
  source       = "./modules/security"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

# ALB module
module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
}

# Render user_data at root and pass to compute module
locals {
  rendered_user_data = templatefile("${path.module}/user_data.tftpl", {
    index_message = "Hello from the nginx server deployed by Terraform!"
  })
}

# Compute module (ASG + Launch Template). Pass ALB target group and SGs
module "compute" {
  source             = "./modules/compute"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  app_sg_id          = module.security.app_sg_id
  alb_tg_arn         = module.alb.target_group_arn
  key_name           = var.key_name
  user_data          = local.rendered_user_data
}

# RDS module — primary Multi-AZ + read replica
module "rds" {
  source        = "./modules/rds"
  project_name  = var.project_name
  db_subnet_ids = module.vpc.private_subnet_ids
  db_sg_id      = module.security.rds_sg_id

  # BEGIN-CHANGE: RDS credentials (change to strong password)
  db_name            = var.db_name
  db_master_username = var.db_master_username
  db_master_password = var.db_master_password # CHANGE THIS BEFORE APPLY
  # END-CHANGE
}
