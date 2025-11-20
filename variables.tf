###############################
# BEGIN-CHANGE: global settings
###############################

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "uber-clone"
}

# Key pair name (must already exist in AWS console for that region)
variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = ""
}

###############################
# END-CHANGE
###############################

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of AZs to provision (recommend 2 or 3)"
  type        = number
  default     = 2
}

###############################
# Database variables (Required)
###############################

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "uberclone"
}

variable "db_master_username" {
  description = "Master username for RDS"
  type        = string
  default     = "admin"
}

variable "db_master_password" {
  description = "Master password for RDS"
  type        = string
  sensitive   = true
}
