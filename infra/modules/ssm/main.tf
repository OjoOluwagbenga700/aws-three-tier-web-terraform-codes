
resource "aws_ssm_parameter" "db_username" {
  name  = "/app/db_username"
  type  = "SecureString"
  value = var.db_username
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/app/db_password"
  type  = "SecureString"
  value = var.db_password
}

resource "aws_ssm_parameter" "db_host" {
  name  = "/app/db_host"
  type  = "String"
  value = var.db_host_endpoint
}

resource "aws_ssm_parameter" "db_database" {
  name  = "/app/db_database"
  type  = "String"
  value = var.db_database
}

   resource "aws_ssm_parameter" "internal_alb_dns" {
     name  = "/app/internal_alb_dns"
     type  = "String"
     value = var.internal_alb_dns_name
   }
