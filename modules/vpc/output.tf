
output "vpc_id" {
  value = aws_vpc.main.id
}

# output "subnet_ids" {
#   value = aws_subnet.subnet[*].ids
# }
# output "subnet_ids" {
#   value = values(aws_subnet.subnet)[*].id
  
# }