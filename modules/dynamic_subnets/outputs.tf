output "private" {
  value = {
    for az, subnet in aws_subnet.private :
    az => subnet.id
  }
}

output "public" {
  value = {
    for az, subnet in aws_subnet.public :
    az => subnet.id
  }
}