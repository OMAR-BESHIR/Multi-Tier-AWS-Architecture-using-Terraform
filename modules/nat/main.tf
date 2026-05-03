resource "aws_eip" "eip_a" {
  domain = "vpc"
}

resource "aws_eip" "eip_b" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.eip_a.id
  subnet_id     = var.public_subnets[0]
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.eip_b.id
  subnet_id     = var.public_subnets[1]
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = var.public_subnets[0]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = var.public_subnets[1]
  route_table_id = aws_route_table.public.id
}

# Private Route Tables
resource "aws_route_table" "private_a" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = var.private_subnets[0]
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = var.private_subnets[1]
  route_table_id = aws_route_table.private_b.id
}