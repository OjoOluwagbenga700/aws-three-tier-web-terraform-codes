output "external_alb_dns_name" {
  description = "DNS name of the internal ALB"
  value       = aws_lb.external.dns_name
}

output "web_asg_name" {
  description = "Name of the webautoscaling group"
  value       = aws_autoscaling_group.web-asg.name
}
