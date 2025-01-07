resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public_subnets[0].id
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "public_rt" {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

resource "aws_route_table_association" "private_rt" {
  count = length(aws_subnet.private_subnets)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}




# VPC Resource
/*resource "aws_vpc" "main_vpc" {  # Changed main-vpc to main_vpc
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id  # Changed main-vpc to main_vpc
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id  # Changed main-vpc to main_vpc
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id  # Changed main-vpc to main_vpc
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id  # Changed main-vpc to main_vpc
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

# Create a NAT Gateway in the first public subnet
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnets[0].id  # Use the first public subnet
  depends_on    = [aws_internet_gateway.igw]
}

# Public Route Table Association
resource "aws_route_table_association" "public_rt" {
  count = length(aws_subnet.public_subnets)  # Corrected the reference to aws_subnet.public_subnets
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id  # Changed main-vpc to main_vpc
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

# Private Route Table Association
resource "aws_route_table_association" "private_rt" {
  count = length(aws_subnet.private_subnets)  # Corrected the reference to aws_subnet.private_subnets
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}
*/
