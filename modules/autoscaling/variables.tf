variable "web_sg" {
  description = "Security Group ID for web instances"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB Target Group"
  type        = string
}