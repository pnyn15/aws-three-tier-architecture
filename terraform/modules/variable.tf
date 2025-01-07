variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type = list(string)
}

variable "availability_zones" {
  description = "The availability zones for the subnets"
  type = list(string)
}

variable "extlb_port" {
  description = "Port for the external load balancer"
  type = number
}

variable "webtier_port" {
  description = "Port for the web tier"
  type = number
}

variable "intlb_port" {
  description = "Port for the internal load balancer"
  type = number
}

variable "apptier_port" {
  description = "Port for the app tier"
  type = number
}

variable "db_port" {
  description = "Port for the database"
  type = number
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instances"
  type = string
}

variable "instance_type" {
  description = "The type of instance to deploy (e.g., t2.micro, t3.medium)"
  type = string
}

variable "iam_role_name" {
  description = "The IAM role name for EC2 instances"
  type = string
}

variable "db_instance_class" {
  description = "The instance class for the database (e.g., db.t3.micro)"
  type = string
}

variable "db_instance_subnetgroup" {
  description = "Subnet group for the database instance"
  type = string
}

variable "username" {
  description = "The username for the database"
  type = string
}

variable "password" {
  description = "The password for the database"
  type = string
  sensitive = true
}

variable "key_name" {
  description = "The SSH key name for EC2 instances"
  type = string
}

variable "public_subnets" {
  description = "The list of public subnet IDs"
  type = list(string)
}

variable "private_subnets" {
  description = "The list of private subnet IDs"
  type = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type = string
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot before deleting the DB instance"
  type        = bool
  default     = true
}
variable "public_instance_id" {
  description = "Public instance ids"
  type = string
}
variable "private_instance_id" {
  description = "Private instances ids"
  type = string
}