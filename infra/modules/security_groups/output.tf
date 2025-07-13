output "private_db_tier_sg_id" {
  description = "The ID of the private database tier security group"
  value       = aws_security_group.private_db_tier_sg.id
  
}

output "internal_alb_sg_id" {
  description = "The ID of the internal ALB security group"
  value       = aws_security_group.internal_alb_sg.id
}

output "private_app_tier_sg_id" {
  description = "The ID of the private app tier security group"
  value       = aws_security_group.private_app_tier_sg.id
}

output "external_alb_sg_id" {
 description = "The ID of the external ALB security group" 
  value       = aws_security_group.external_alb_sg.id
}

output "web_tier_sg_id" {
 description = "The ID of the internal ALB security group" 
  value       = aws_security_group.web_tier_sg.id 
}