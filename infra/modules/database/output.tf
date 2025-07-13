output "db_host_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "db_reader_endpoint" {
  value = aws_rds_cluster.aurora.reader_endpoint
}