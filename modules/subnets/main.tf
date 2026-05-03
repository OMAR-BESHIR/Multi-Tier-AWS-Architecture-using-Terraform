resource "aws_subnet" "public_a" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_public_a
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_b" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_public_b
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_a" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_private_a
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_b" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_private_b
  availability_zone = "us-east-1b"
}