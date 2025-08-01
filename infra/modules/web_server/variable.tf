variable "project_name" {
  description = "Project name for tagging resources"
  type        = string
  default     = "3tier"
}
variable "web_instance_type" {
  description = "Instance type for the web server EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "web_asg_min_size" {
  description = "Minimum number of web servers in the ASG"
  type        = number
  default     = 1
}

variable "web_asg_max_size" {
  description = "Maximum number of web servers in the ASG"
  type        = number
  default     = 1
}

variable "web_asg_desired_capacity" {
  description = "Desired number of web servers in the ASG"
  type        = number
  default     = 1
}



variable "public_subnet_names" {
  description = "List of names for public subnets"
  type        = list(string)
  default     = ["public-web-subnet-1", "public-web-subnet-2"]
}

variable "vpc_id" {
  description = "VPC ID where the web server resources will be deployed"
  type        = string
  default     = ""  # This should be set to the VPC ID where the web tier will be deployed
  
}
variable "external_alb_sg_id" {
  description = "Security group ID for the external ALB"
  type        = string
  default     = ""  # This should be set to the security group ID for the external ALB
  
}
variable "ec2_instance_profile_name" {
  description = "Name of the EC2 instance profile to attach to the web server instances"
  type        = string
  default     = ""  # This should be set to the name of the EC2 instance profile
  
}

variable "web_tier_sg_id" {
  description = "Security group ID for the web tier"
  type        = string
  default     = ""  # This should be set to the security group ID for the web tier
  
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs where the web server instances will be launched"
  type        = list(string)
  default     = []  # This should be set to the list of public subnet IDs
  
}