variable "env" { type = string }
variable "aws_profile" {}
variable "aws_region" {}
variable "vpc_cidr" { type = string }
variable "subnets" {
  type = map(object({
    type  = string
    cidrs = list(string)
  }))
}