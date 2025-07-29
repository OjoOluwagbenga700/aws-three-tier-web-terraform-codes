variable "project_name" {
  description = "Name of the project, used for naming resources"
  type        = string

}
variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}
variable "azs" {
  description = "List of availability zones to use for the VPC"
  type        = list(string)
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}
variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)

}
variable "public_subnet_names" {
  description = "List of names for public subnets"
  type        = list(string)

}
variable "private_subnet_names" {
  description = "List of names for private subnets"
  type        = list(string)
}


variable "private_subnets" {
  description = "List of CIDR blocks for private application subnets"
  type        = list(string)

}

variable "identifier" {
  description = "Identifier for the database instance"
  type        = string

}
variable "storage" {
  description = "Storage configuration for the database"
  type        = string

}
variable "engine" {
  description = "Database engine to use"
  type        = string


}
variable "engine_version" {
  description = "Version of the database engine"
  type        = string
}
variable "instance_class" {
  description = "Instance class for the database"
  type        = string

}
variable "db_name" {
  description = "Name of the database"
  type        = string

}


variable "db_username" {
  description = "Database username for the app"
  type        = string
}

variable "db_password" {
  description = "Database password for the app"
  type        = string
  sensitive   = true
}

variable "app_instance_type" {
  description = " instance_type for web server"
  type        = string

}







