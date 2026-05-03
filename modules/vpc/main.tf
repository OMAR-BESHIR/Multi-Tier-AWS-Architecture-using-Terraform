resource "aws_vpc" "my-vpc" {
  cidr_block = var.cidr
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id 
}

