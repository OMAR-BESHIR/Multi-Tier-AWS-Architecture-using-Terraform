variable "web_sg" {
  description = "Security Group ID for web instances"
  type        = string
} 

variable "private_subnets" {
  description = "Private subnets for EC2"
  type        = list(string)
}