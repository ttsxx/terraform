output "vpc" {
  value = {
    name = aws_vpc.vpc.tags["Name"]
    id   = aws_vpc.vpc.id
  }
}