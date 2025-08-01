module "networking" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr
  azs  = var.azs
  

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  private_subnet_names = var.private_subnet_names
  public_subnet_names = var.public_subnet_names


  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # Tag all public subnets as web tier
  public_subnet_tags = {
    "Tier" = "web"
  }
}

