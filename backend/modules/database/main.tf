resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  database_name          = var.db_name
  master_username        = var.db_username
  master_password        = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  vpc_security_group_ids = [var.private_db_tier_sg_id]
  skip_final_snapshot    = true
  tags = {
    Name = "${var.identifier}-aurora-cluster"
  }
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = 2
  identifier         = "${var.identifier}-instance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.aurora.engine
  engine_version     = aws_rds_cluster.aurora.engine_version
  publicly_accessible = false
  tags = {
    Name = "${var.identifier}-aurora-instance-${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "main_subnet_group"
  description = "Our main group of subnets"
  subnet_ids  = var.private_subnet_ids
}