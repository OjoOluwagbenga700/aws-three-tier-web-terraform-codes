output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.networking.vpc_id
  
}


output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.networking.private_subnets
  
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.networking.public_subnets

}