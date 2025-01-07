output "alb_1_dns" {
  description = "DNS name of the first Application Load Balancer"
  value       = aws_lb.alb_1.dns_name
}

output "tg_1_arn" {
  description = "ARN of the target group for Load Balancer 1"
  value       = aws_lb_target_group.tg_1.arn
}
