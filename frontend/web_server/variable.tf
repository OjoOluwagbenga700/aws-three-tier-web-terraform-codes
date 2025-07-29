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

variable "asg_min_size" {
  description = "Minimum number of web servers in the ASG"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of web servers in the ASG"
  type        = number
  default     = 1
}

variable "asg_desired_capacity" {
  description = "Desired number of web servers in the ASG"
  type        = number
  default     = 1
}



variable "public_subnet_names" {
  description = "List of names for public subnets"
  type        = list(string)
  default     = ["public-web-subnet-1", "public-web-subnet-2"]
}
