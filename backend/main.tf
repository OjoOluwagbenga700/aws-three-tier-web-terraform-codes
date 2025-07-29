module "networking" {
  source               = "./modules/networking"
  project_name         = var.project_name
  azs                  = var.azs
  vpc_cidr             = var.vpc_cidr
  public_subnets       = var.public_subnets
  public_subnet_names  = var.public_subnet_names
  private_subnet_names = var.private_subnet_names
  private_subnets      = var.private_subnets
}

module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project_name
  vpc_id       = module.networking.vpc_id
  depends_on   = [module.networking]
}

module "database" {
  source = "./modules/database"

  private_db_tier_sg_id = module.security_groups.private_db_tier_sg_id
  private_subnet_ids    = module.networking.private_subnet_ids
  identifier            = var.identifier
  storage               = var.storage
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  depends_on            = [module.security_groups, module.networking]
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "app_server" {
  source                    = "./modules/app_server"
  project_name              = var.project_name
  vpc_id                    = module.networking.vpc_id
  private_subnet_ids        = slice(module.networking.private_subnet_ids, 0, length(var.azs))
  internal_alb_sg_id        = module.security_groups.internal_alb_sg_id
  app_tier_sg_id            = module.security_groups.private_app_tier_sg_id
  app_instance_type         = var.app_instance_type
  asg_min_size              = 1
  asg_max_size              = 1
  asg_desired_capacity      = 1
  ec2_instance_profile_name = module.iam.ec2_instance_profile_name
  depends_on                = [module.iam, module.networking, module.security_groups, module.database]
}

module "ssm" {
  source                = "./modules/ssm"
  db_username           = var.db_username
  db_password           = var.db_password
  db_host_endpoint      = module.database.db_host_endpoint
  db_database           = var.db_name
  internal_alb_dns_name = module.app_server.internal_alb_dns_name
  depends_on            = [module.app_server]
}

