##########################################
# DB Subnet Group
##########################################
resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

##########################################
# PRIMARY DB INSTANCE (Single AZ)
# Free-tier safe + required for read replica
##########################################
resource "aws_db_instance" "primary" {
  identifier              = "${var.project_name}-db-primary"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage

  db_name                 = var.db_name
  username                = var.db_master_username
  password                = var.db_master_password

  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.db_sg_id]

  backup_retention_period = 1
  skip_final_snapshot     = true
  publicly_accessible     = false
  deletion_protection     = false

  tags = {
    Name = "${var.project_name}-db-primary"
  }

  lifecycle {
    create_before_destroy = true
  }
}

##########################################
# READ REPLICA
##########################################
resource "aws_db_instance" "read_replica" {
  identifier              = "${var.project_name}-db-replica"
  replicate_source_db     = aws_db_instance.primary.arn

  instance_class          = var.db_instance_class
  publicly_accessible     = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [var.db_sg_id]

  tags = {
    Name = "${var.project_name}-db-replica"
  }

  depends_on = [
    aws_db_instance.primary
  ]
}

