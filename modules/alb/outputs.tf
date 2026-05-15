output "dns_name" {
  value = aws_lb.this.dns_name
}

output "arn_suffix" {
  value = aws_lb.this.arn_suffix
}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn
}

output "security_group_id" {
  value = aws_security_group.alb.id
}

output "zone_id" {
  value = aws_lb.this.zone_id
}
