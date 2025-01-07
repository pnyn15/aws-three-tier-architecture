# Internet-Facing Load Balancer (External)
resource "aws_lb" "alb_1" {
  name                   = var.alb_1_name
  internal               = false  # Internet-facing
  load_balancer_type     = "application"
  security_groups        = [var.ext_lb_sg]
  subnets                = var.public_subnets
  enable_deletion_protection = false
}

# Internal Load Balancer
resource "aws_lb" "alb_2" {
  name                   = var.alb_2_name
  internal               = true  # Internal-facing
  load_balancer_type     = "application"
  security_groups        = [var.int_lb_sg]
  subnets                = var.private_subnets
  enable_deletion_protection = false
}

# Target Group for Internet-Facing Load Balancer
resource "aws_lb_target_group" "tg_1" {
  name      = var.alb_1_target_group_name
  port      = 80
  protocol  = "HTTP"
  vpc_id    = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for Internal Load Balancer
resource "aws_lb_target_group" "tg_2" {
  name      = var.alb_2_target_group_name
  port      = 5000
  protocol  = "HTTP"  # Use TCP for non-HTTP/HTTPS traffic
  vpc_id    = var.vpc_id

health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Attach EC2 Instances to Internet-Facing Load Balancer
resource "aws_lb_target_group_attachment" "tg_1_attachment" {
  target_group_arn = aws_lb_target_group.tg_1.arn
  target_id        = var.public_instance_id[0]  # Use the first (and only) instance
  port             = 80
}

# Attach EC2 Instances to Internal Load Balancer
resource "aws_lb_target_group_attachment" "tg_2_attachment" {
  target_group_arn = aws_lb_target_group.tg_2.arn
  target_id        = var.private_instance_id[0]  # Use the first (and only) instance
  port             = 5000
}

# Add Listener to Internet-Facing Load Balancer
resource "aws_lb_listener" "alb_1_listener" {
  load_balancer_arn = aws_lb.alb_1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"  # Forward traffic to the target group
    target_group_arn = aws_lb_target_group.tg_1.arn  # Forward to tg_1
  }
}

# Add Listener to Internal Load Balancer
resource "aws_lb_listener" "alb_2_listener" {
  load_balancer_arn = aws_lb.alb_2.arn
  port              = 5000
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"  # Forward traffic to the target group
    target_group_arn = aws_lb_target_group.tg_2.arn  # Forward to tg_2
  }
}
