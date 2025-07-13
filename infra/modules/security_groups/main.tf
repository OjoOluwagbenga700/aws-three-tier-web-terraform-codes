# Security group for external Load Balancer
resource "aws_security_group" "external_alb_sg" {
  name        = "${var.project_name}-external-alb-sg"
  description = "Security group for external ALB"
  vpc_id      = var.vpc_id

  # Allow inbound communication from internet
  ingress {
    description = "Allow inbound HTTPS traffic from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow inbound HTTP traffic from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.project_name}-external-alb-sg"
    Project    = var.project_name
  }
}

# Security group for web tier (public subnets)
resource "aws_security_group" "web_tier_sg" {
  name        = "${var.project_name}-web-tier-sg"
  description = "Security group for web tier"
  vpc_id      = var.vpc_id


  # Allow all traffic from external ALB
  ingress {
    description = "Allow http and https traffic from external ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.external_alb_sg.id]
  }

  ingress {
    description     = "Allow inbound HTTPS traffic from internet"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.external_alb_sg.id]
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.project_name}-web-tier-sg"
    Project    = var.project_name
  }

}

# Security group for internal Load Balancer
resource "aws_security_group" "internal_alb_sg" {
  name        = "${var.project_name}-internal-alb-sg"
  description = "Security group for internal ALB"
  vpc_id      = var.vpc_id

  # Allow inbound communication from web tier
  ingress {
    description     = "Allow inbound HTTPS traffic from internal ALB"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier_sg.id]
  }
  ingress {
    description     = "Allow inbound HTTP traffic from internal ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.project_name}-internal-alb-sg"
    Project    = var.project_name
  }
}


# Security group for private app tier 
resource "aws_security_group" "private_app_tier_sg" {
  name        = "${var.project_name}-private-app-tier-sg"
  description = "Security group for private app tier"
  vpc_id      = var.vpc_id

  # Allow inbound communication from internal alb
  ingress {
    description     = "Allow inbound traffic from internal ALB"
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_alb_sg.id]
  }
  ingress {
    description     = "Allow inbound HTTP traffic from internal ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_alb_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.project_name}-private-app-tier-sg"
    Project    = var.project_name
  }
}



# Security group for private database tier 
resource "aws_security_group" "private_db_tier_sg" {
  name        = "${var.project_name}-private-db-tier-sg"
  description = "Security group for private database tier"
  vpc_id      = var.vpc_id

  # Allow inbound communication from web tier
  ingress {
    description     = "Allow inbound traffic from private app tier"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_app_tier_sg.id]
  }
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  
  tags = {
    Name       = "${var.project_name}-private-db-tier-sg"
    Project    = var.project_name
  }
}