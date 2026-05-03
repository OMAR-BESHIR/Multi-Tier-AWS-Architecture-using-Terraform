resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "db_secret" {
  name = "rds-db-secret"
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id = aws_secretsmanager_secret.db_secret.id

  secret_string = jsonencode({
    username = "admin"
    password = random_password.db_password.result
  })
}

resource "aws_db_subnet_group" "db" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnets
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  db_name                = "project_rds"

  username = jsondecode(aws_secretsmanager_secret_version.db_secret_value.secret_string).username
  password = jsondecode(aws_secretsmanager_secret_version.db_secret_value.secret_string).password

  multi_az             = true
  storage_encrypted    = true
  publicly_accessible  = false

  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [var.db_sg]

  skip_final_snapshot = true
}