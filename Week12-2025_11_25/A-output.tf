output "website_url" {
  value = "http://${aws_lb.shadowtitan_alb.dns_name}"
}
