# VPC ID for the Security Groups
variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}

# Port for the External Load Balancer Security Group
variable "extlb_port" {
  description = "The port to allow for the external load balancer"
  type        = number
}

# Port for the Web Tier Security Group
variable "webtier_port" {
  description = "The port to allow for the web tier"
  type        = number
}

# Port for the Internal Load Balancer Security Group
variable "intlb_port" {
  description = "The port to allow for the internal load balancer"
  type        = number
}

# Port for the Application Tier Security Group
variable "apptier_port" {
  description = "The port to allow for the application tier"
  type        = number
}

# Port for the Database Security Group
variable "db_port" {
  description = "The port to allow for the database"
  type        = number
}
