variable "access_key" {
  type        = string
  description = "my_access_key"
}

variable "secret_key" {
  type        = string
  description = "my_secret_key"
}

variable "my_project_name" {
  type        = string
  description = "name of the project"
}

variable "my_project_env" {
  type        = string
  description = "project environment"
}

variable "my_project_owner" {
  type        = string
  description = "project owner"
}

variable "region" {
  type        = string
  description = "my_region"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC network address"
}

variable "my_no_of_subnets" {
  type = number
}

variable "instance_type" {
  type        = string
  description = "instance_type"
}

variable "ami_id" {
  type        = string
  description = "ami"
}

variable "domain" {
  type        = string
  description = "name"
}


variable "hostname" {
  type        = string
  description = "name"
}

