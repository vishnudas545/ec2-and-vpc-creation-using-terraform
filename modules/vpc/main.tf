resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.project_env}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-${var.project_env}"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = var.no_of_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 4, "${count.index}")
  availability_zone       = data.aws_availability_zones.available.names["${count.index}"]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.project_env}-public-${count.index + 1}"
  }
}


resource "aws_subnet" "pvt_subnets" {
  count                   = var.no_of_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 4, "${count.index + var.no_of_subnets}")
  availability_zone       = data.aws_availability_zones.available.names["${count.index}"]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project_name}-${var.project_env}-private-${count.index + 1}"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnets[1].id
  tags = {
    Name = "${var.project_name}-${var.project_env}"
  }

  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project_name}-${var.project_env}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    Name = "${var.project_name}-${var.project_env}-private"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.no_of_subnets
  subnet_id      = aws_subnet.public_subnets["${count.index}"].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
  count          = var.no_of_subnets
  subnet_id      = aws_subnet.pvt_subnets["${count.index}"].id
  route_table_id = aws_route_table.private.id
}
