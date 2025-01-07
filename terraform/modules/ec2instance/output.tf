  # Output for the Public Instance
  output "public_instance_id" {
    description = "The ID of the public EC2 instance"
    value       = aws_instance.public_instance.id
  }

  output "public_instance_public_ip" {
    description = "The public IP address of the public EC2 instance"
    value       = aws_instance.public_instance.public_ip
    sensitive   = false  # Not sensitive, but can be sensitive if there are security concerns
  }

  # Output for the Private Instance
  output "private_instance_id" {
    description = "The ID of the private EC2 instance"
    value       = aws_instance.private_instance.id
  }

  output "private_instance_private_ip" {
    description = "The private IP address of the private EC2 instance"
    value       = aws_instance.private_instance.private_ip
    sensitive   = true  # Marked as sensitive to prevent accidental exposure
  }

  output "aws_db_subnet_group" {
    value = aws_db_subnet_group.my_db_subnet_group
    
  }
