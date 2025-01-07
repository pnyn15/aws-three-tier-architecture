resource "aws_security_group" "ext_lb_sg" {
  vpc_id = var.vpc_id
  
  # Allow inbound traffic from the same security group (internal communication)
  ingress {
    protocol   = "tcp"
    self       = true
    from_port  = var.extlb_port
    to_port    = var.extlb_port
  }
    # Allow inbound traffic from the outside world (any IP address)
  ingress {
    protocol   = "tcp"
    from_port  = var.extlb_port
    to_port    = var.extlb_port
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IPv4 address
  }

  # Allow all outbound traffic
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_tier_sg" {
  vpc_id = var.vpc_id
  
  # Allow inbound traffic from the same security group (internal communication)
  ingress {
    protocol   = "tcp"
    self       = true
    from_port  = var.webtier_port
    to_port    = var.webtier_port
  }

  # Allow inbound traffic from external LB (ext_lb_sg) on port 80
  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.ext_lb_sg.id]  # Use the ID of the external LB SG
  }
  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "int_lb_sg" {
  vpc_id = var.vpc_id

  # Allow internal communication on the internal load balancer port
  ingress {
    protocol   = "tcp"
    self       = true
    from_port  = var.intlb_port
    to_port    = var.intlb_port
  }

  # Allow inbound traffic from web tier (web_tier_sg) on port 80
  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.web_tier_sg.id]  # Use the ID of the web tier SG
  }
  ingress {
    protocol        = "tcp"
    from_port       = 5000
    to_port         = 5000
    security_groups = [aws_security_group.web_tier_sg.id]  # Use the ID of the web tier SG
  }

  # Allow all outbound traffic
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "apptier_sg" {
  vpc_id = var.vpc_id

  # Allow internal communication on the app tier port
  ingress {
    protocol   = "tcp"
    self       = true
    from_port  = var.apptier_port
    to_port    = var.apptier_port
  }

  # Allow inbound traffic from internal load balancer (int_lb_sg) on port 5000
  ingress {
    protocol        = "tcp"
    from_port       = 5000
    to_port         = 5000
    security_groups = [aws_security_group.int_lb_sg.id]  # Use the ID of the internal LB SG
  }

  # Allow all outbound traffic
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id

  # Allow internal communication on the DB port
  ingress {
    protocol   = "tcp"
    self       = true
    from_port  = var.db_port
    to_port    = var.db_port
  }

  # Allow inbound traffic from app tier (apptier_sg) on MySQL port (3306)
  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [aws_security_group.apptier_sg.id]  # Use the ID of the app tier SG
  }

  # Allow all outbound traffic
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
