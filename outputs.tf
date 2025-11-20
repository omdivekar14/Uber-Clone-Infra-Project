output "alb_dns" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns
}

output "asg_name" {
  description = "Autoscaling Group name"
  value       = module.compute.asg_name
}

output "rds_primary_endpoint" {
  description = "RDS primary endpoint"
  value       = module.rds.primary_endpoint
}

output "rds_read_replica_endpoint" {
  description = "RDS read replica endpoint"
  value       = module.rds.read_replica_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
