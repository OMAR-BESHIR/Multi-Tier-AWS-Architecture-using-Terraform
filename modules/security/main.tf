resource "aws_security_group" "alb" {
  name   = "alb-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "web" {
  name   = "web-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "rds" {
  name   = "rds-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "alb_http_in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "alb_to_web" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "web_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "web_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "rds_from_web" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = aws_security_group.web.id
}