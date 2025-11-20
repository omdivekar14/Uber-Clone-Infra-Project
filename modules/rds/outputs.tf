output "primary_endpoint" {
  value = aws_db_instance.primary.address
}

output "read_replica_endpoint" {
  value = aws_db_instance.read_replica.address
}

