variable "vpc_id" { type = string }
variable "vpc_name" { type = string }
variable "subnets" {
  type = map(object({
    type  = string
    cidrs = list(string)
  }))
}