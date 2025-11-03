variable "project_name" {
  type        = string
  description = "name of the project"
  default     = "test"
}

variable "project_env" {
  type        = string
  description = "project environment"
  default     = "test"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC network address"
}

variable "no_of_subnets" {
  type = number
}

