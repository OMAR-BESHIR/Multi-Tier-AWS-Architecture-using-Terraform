resource "aws_launch_template" "lt" {
  image_id = "ami-0dfcb1ef8550277af"
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.web_sg]
}

resource "aws_autoscaling_group" "asg" {
  min_size = 2
  max_size = 4
  desired_capacity = 2
  vpc_zone_identifier = var.subnets

  target_group_arns = [var.target_group_arn]

  launch_template {
    id = aws_launch_template.lt.id
    version = "$Latest"
  }
}