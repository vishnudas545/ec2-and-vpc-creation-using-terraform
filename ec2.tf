resource "aws_instance" "frontend" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "pv95"
  #user_data              = "file(userdata.sh)"
  vpc_security_group_ids = [aws_security_group.frontend.id]
  subnet_id              = module.vpc.public2_subnet_id
  tags = {
    Name = "frontend"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "frontend" {
  name        = "${var.my_project_name}-${var.my_project_env}-frontend"
  description = "Allow SSH (22), HTTP (80) and HTTPS (443)"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${var.my_project_name}-${var.my_project_env}-frontend"
  }
}

variable "frontend_sg_ports" {
  type        = list(any)
  description = "all sg ports need to open"
  default     = ["22", "25", "80", "443", "143", "2049"]
}

resource "aws_security_group_rule" "frontend_rules" {

  for_each = toset(var.frontend_sg_ports)
  #  count = length(var.frontend_sg_ports)

  type      = "ingress"
  from_port = each.key
  to_port   = each.key
  #  from_port         = var.frontend_sg_ports["${count.index}"]
  #  to_port           = var.frontend_sg_ports["${count.index}"]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.frontend.id
}

resource "aws_security_group_rule" "db_prod" {

  count = var.my_project_env == "prod" ? 1 : 0

  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["172.168.2.6/32"]
  security_group_id = aws_security_group.frontend.id
}

resource "aws_security_group_rule" "db_dev" {

  count = var.my_project_env == "dev" ? 1 : 0

  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.frontend.id
}

