output "vpc_id" {
 value = aws_vpc.main.id
}

output "public1_subnet_id" {
 value = aws_subnet.public_subnets[0].id
}

output "public2_subnet_id" {
 value = aws_subnet.public_subnets[1].id
}

output "public3_subnet_id" {
 value = aws_subnet.public_subnets[2].id
}

output "private1_subnet_id" {
 value = aws_subnet.pvt_subnets[0].id
}

output "private2_subnet_id" {
 value = aws_subnet.pvt_subnets[1].id
}

output "private3_subnet_id" {
 value = aws_subnet.pvt_subnets[2].id
}

