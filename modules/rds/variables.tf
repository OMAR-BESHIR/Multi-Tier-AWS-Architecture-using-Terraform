variable "subnets" {
  description = "Private subnets for RDS"
  type        = list(string)
}

variable "db_sg" {
  description = "DB Security Group"
  type        = string
}