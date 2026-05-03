output "db_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "secret_name" {
  value = aws_secretsmanager_secret.db_secret.name
}