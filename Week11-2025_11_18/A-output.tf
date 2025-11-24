output "website_url" {
  value = "http://${aws_instance.web-server.public_dns}"
}
