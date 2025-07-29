variable "project_name" {
  description = "Project name for tagging resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the ALB and target group"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the app tier"
  type        = list(string)
}

variable "internal_alb_sg_id" {
  description = "Security group ID for the internal ALB"
  type        = string
}

variable "app_tier_sg_id" {
  description = "Security group ID for the app tier EC2 instances"
  type        = string
}

variable "app_instance_type" {
  description = "Instance type for the app server EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "user_data" {
  description = "User data script for app server EC2 instances"
  type        = string
  default     = ""
}

variable "asg_min_size" {
  description = "Minimum number of app servers in the ASG"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of app servers in the ASG"
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "Desired number of app servers in the ASG"
  type        = number
  default     = 2
}

variable "ec2_instance_profile_name" {
  description = "IAM instance profile name for EC2 instances in the app server ASG"
  type        = string
}
