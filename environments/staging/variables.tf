variable "env" {}
variable "aws_region" {}
variable "aws_profile" {}
variable "vpc_cidrs" { type = list(string) }
variable "public_subnet_cidrs" { type = map(string) }
variable "private_subnet_cidrs" { type = map(string) }
