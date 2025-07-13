output "internal_alb_dns_name" {
  description = "DNS name of the internal ALB"
  value       = aws_lb.internal.dns_name
}

output "app_asg_name" {
  description = "Name of the app autoscaling group"
  value       = aws_autoscaling_group.app.name
}
