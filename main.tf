module "vpc" {
  source = "/home/ec2-user/modules/vpc/"

  project_name   = var.my_project_name
  project_env    = var.my_project_env
  no_of_subnets  = var.my_no_of_subnets
  vpc_cidr_block = var.vpc_cidr_block

}


##creating A record for prod

resource "aws_route53_record" "frontend_prod" {

  count = var.my_project_env == "prod" ? 1 : 0

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.hostname}.${var.domain}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.public_ip]
}


##creating A record for dev

resource "aws_route53_record" "frontend_dev" {

  count = var.my_project_env == "dev" ? 1 : 0

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.hostname}.${var.domain}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.public_ip]
}

