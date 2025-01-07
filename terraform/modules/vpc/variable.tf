# CIDR block for the VPC
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

# List of Availability Zones for the subnets
variable "availability_zones" {
  description = "List of Availability Zones for the subnets"
  type        = list(string)
}

# List of CIDR blocks for the public subnets
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

# List of CIDR blocks for the private subnets
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}
