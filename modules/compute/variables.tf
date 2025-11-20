variable "project_name" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "app_sg_id" { type = string }
variable "alb_tg_arn" { type = string }
variable "key_name" { type = string }
variable "user_data" { type = string }  # rendered template passed from root
