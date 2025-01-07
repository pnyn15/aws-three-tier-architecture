# Output for the External Load Balancer Security Group ID
output "ext_lb_sg" {
  description = "The ID of the security group for the external load balancer"
  value       = aws_security_group.ext_lb_sg.id
}

# Output for the Web Tier Security Group ID
output "web_tier_sg" {
  description = "The ID of the security group for the web tier"
  value       = aws_security_group.web_tier_sg.id
}

# Output for the Internal Load Balancer Security Group ID
output "int_lb_sg" {
  description = "The ID of the security group for the internal load balancer"
  value       = aws_security_group.int_lb_sg.id
}

# Output for the Application Tier Security Group ID
output "apptier_sg" {
  description = "The ID of the security group for the application tier"
  value       = aws_security_group.apptier_sg.id
}

# Output for the Database Security Group ID
output "db_sg" {
  description = "The ID of the security group for the database tier"
  value       = aws_security_group.db_sg.id
}
