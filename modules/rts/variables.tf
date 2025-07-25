variable "vpc_id" { type = string }
variable "igw_id" { type = string }
variable "vpc_name" { type = string }
variable "public_subnets" { type = map(string) }
variable "private_subnets" { type = map(map(string)) }
variable "natgw_ids" { type = map(string)  }
variable "cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

