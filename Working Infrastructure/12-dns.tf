locals {
    domain_name = "blueoceanblackwaves.com"
}

data "aws_route53_zone" "main" {
  name         = local.domain_name
  private_zone = false
}

# Find a certificate that is issued
data "aws_acm_certificate" "main" {
  domain   = local.domain_name
  statuses = ["ISSUED"]
  most_recent = true
}

# resource "aws_route53_record" "www" {
#   zone_id = data.aws_route53_zone.selected.zone_id
#   name    = "www.${data.aws_route53_zone.selected.name}"
#   type    = "A"
#   ttl     = "300"
#   records = ["10.0.0.1"]