variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_sg" {
  description = "Security Group ID for the ALB"
  type        = string
}

variable "web1_id" {
  description = "ID of web1 EC2 instance"
  type        = string
}

variable "web2_id" {
  description = "ID of web2 EC2 instance"
  type        = string
}