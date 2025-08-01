output "external_alb_dns_name" {
  description = "DNS name of the external ALB"
  value       = aws_lb.external.dns_name
}

