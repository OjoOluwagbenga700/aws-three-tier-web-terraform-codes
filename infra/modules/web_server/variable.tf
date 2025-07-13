variable "project_name" {
  description = "Project name for tagging resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the ALB and target group"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the web tier"
  type        = list(string)
}

variable "web_tier_sg_id" {
  description = "Security group ID for the web tier EC2 instances"
  type        = string
}

variable "external_alb_sg_id" {
  description = "Security group ID for the external ALB"
  type        = string
}


variable "web_instance_type" {
  description = "Instance type for the web server EC2 instances"
  type        = string
  default     = "t3.micro"
}

variable "user_data" {
  description = "User data script for web server EC2 instances"
  type        = string
  default     = ""
}

variable "asg_min_size" {
  description = "Minimum number of web servers in the ASG"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of web servers in the ASG"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired number of web servers in the ASG"
  type        = number
  default     = 2
}

variable "ec2_instance_profile_name" {
  description = "IAM instance profile name for EC2 instances in the web server ASG"
  type        = string
}
