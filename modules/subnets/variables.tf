variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cidr_public_a" {
  default = "10.0.10.0/24"
}

variable "cidr_public_b" {
  default = "10.0.20.0/24"
}

variable "cidr_private_a" {
  default = "10.0.100.0/24"
}

variable "cidr_private_b" {
  default = "10.0.200.0/24"
}
