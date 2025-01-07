# Output for the VPC ID
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main_vpc.id
}

# Output for Public Subnet IDs
output "public_subnets" {
  description = "List of IDs for the public subnets"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

# Output for Private Subnet IDs
output "private_subnets" {
  description = "List of IDs for the private subnets"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
}
