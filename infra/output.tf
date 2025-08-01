output "internal_alb_dns_name" {
  value = module.app_server.internal_alb_dns_name
}

output "external_alb_dns_name" {
  value = module.web_server.external_alb_dns_name
  
}
