variable "project_name" { type = string }
variable "db_subnet_ids" { type = list(string) }
variable "db_sg_id" { type = string }

variable "db_name" { type = string }
variable "db_master_username" { type = string }
variable "db_master_password" { type = string }

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

