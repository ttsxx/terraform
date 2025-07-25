variable "vpc_id" {}
variable "vpc_cidr" {}
variable "azs" {
  type = list(string)
}
variable "name" {}