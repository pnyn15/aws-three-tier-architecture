# Variable for Load Balancer 1 Name
variable "alb_1_name" {
  description = "Name of Load Balancer 1"
  type        = string
  default     = "alb-1"
}

# Variable for Load Balancer 2 Name
variable "alb_2_name" {
  description = "Name of Load Balancer 2"
  type        = string
  default     = "alb-2"
}

# Variable for Load Balancer 1 Target Group Name
variable "alb_1_target_group_name" {
  description = "Target Group Name for Load Balancer 1"
  type        = string
  default     = "tg-1"
}

# Variable for Load Balancer 2 Target Group Name
variable "alb_2_target_group_name" {
  description = "Target Group Name for Load Balancer 2"
  type        = string
  default     = "tg-2"
}

# Variable for VPC ID
variable "vpc_id" {
  description = "VPC ID where the load balancer and target groups will be created"
  type        = string
}

# Variable for Subnets
variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

# Variable for EC2 Instance IDs of Public Instances
variable "public_instance_id" {
  description = "Public instance ids"
  type = list(string)
}
variable "private_instance_id" {
  description = "Private instances ids"
  type = list(string)
}

# variable for Security groups for load balancers
variable "ext_lb_sg" {
  description = "External load balancer security group"
  type = string
}
variable "int_lb_sg" {
  description = "Internal load balancer security group"
  type = string
}