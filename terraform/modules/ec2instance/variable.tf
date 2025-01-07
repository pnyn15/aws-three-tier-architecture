# AMI ID for the instances
variable "ami_id" { 
  description = "The ID of the AMI to use for the EC2 instances"
  type        = string
}

# Instance type (e.g., t2.micro, t3.medium)
variable "instance_type" {
  description = "The type of instance to deploy (e.g., t2.micro, t3.medium)"
  type        = string
  default     = "t2.micro"  # Default value if not provided
}

# Public Subnet IDs
variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

# Private Subnet IDs
variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

# IAM Role for EC2 instances
variable "iam_role_name" {
  description = "The IAM role name for EC2 instances"
  type        = string
}

# Security Group for Web Tier
variable "web_tier_sg" {
  description = "Security group ID for the web tier"
  type        = string
}

# Security Group for Application Tier
variable "apptier_sg" {
  description = "Security group ID for the application tier"
  type        = string
}

# Security Group for Database
variable "db_sg" {
  description = "Security group ID for the database tier"
  type        = string
}

# Database Instance Class (e.g., db.t3.micro)
variable "db_instance_class" {
  description = "The instance class for the database (e.g., db.t3.micro)"
  type        = string
  default     = "db.t3.micro"  # Default value if not provided
}

# Database Subnet Group
variable "db_instance_subnetgroup" {
  description = "Subnet group for the database instance"
  type        = string
}

# Database Username
variable "username" {
  description = "The username for the database"
  type        = string
}

# Database Password (sensitive)
variable "password" {
  description = "The password for the database"
  type        = string
  sensitive   = true  # Marked as sensitive to avoid accidental exposure
}

# SSH Key Name for EC2 instances
variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot before deleting the DB instance"
  type        = bool
  default     = true
}
