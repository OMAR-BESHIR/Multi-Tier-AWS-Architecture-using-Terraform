resource "aws_instance" "web1" {
  ami = "ami-0dfcb1ef8550277af"
  instance_type = "t3.micro"
  subnet_id = var.private_subnets[0]
  vpc_security_group_ids = [var.web_sg]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Web-Server-1"
  }


  user_data = <<-EOF
  #!/bin/bash
  yum install httpd -y
  systemctl start httpd
  echo "Server A" > /var/www/html/index.html
  EOF
}

resource "aws_instance" "web2" {
  ami = "ami-0dfcb1ef8550277af"
  instance_type = "t3.micro"
  subnet_id = var.private_subnets[1]
  vpc_security_group_ids = [var.web_sg]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "Web-Server-2"
  }
  user_data = <<-EOF
  #!/bin/bash
  yum install httpd -y
  systemctl start httpd
  echo "Server B" > /var/www/html/index.html
  EOF
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ec2_role.name
}