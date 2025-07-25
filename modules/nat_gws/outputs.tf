output "natgw_ids" {
  value = {
    for k, nat in aws_nat_gateway.nat_gws :
    k => nat.id
  }
}