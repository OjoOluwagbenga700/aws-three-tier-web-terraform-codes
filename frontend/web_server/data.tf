data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_vpc" "vpc_id" {

  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-vpc"]
  }

}

data "aws_security_group" "web_tier_sg" {
  name   = "${var.project_name}-web-tier-sg"
  vpc_id = data.aws_vpc.vpc_id.id

}

data "aws_security_group" "external_alb_sg" {
  name   = "${var.project_name}-external-alb-sg"
  vpc_id = data.aws_vpc.vpc_id.id

}

data "aws_subnets" "public_subnets" {

  filter {
    name   = "tag:Name"
    values = var.public_subnet_names
  }

}
data "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-ec2-instance-profile"

}
