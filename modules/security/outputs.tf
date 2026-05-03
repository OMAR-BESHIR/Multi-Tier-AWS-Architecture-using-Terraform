output "alb_sg" {
  value = aws_security_group.alb.id
}

output "web_sg" {
  value = aws_security_group.web.id
}

output "db_sg" {
  value = aws_security_group.rds.id
}