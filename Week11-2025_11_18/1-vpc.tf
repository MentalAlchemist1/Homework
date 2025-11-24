# VPC resource
# This creates the virtual private cloud
resource "aws_vpc" "main" {

  # region = ""

  cidr_block = "10.107.0.0/16"

  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "shai-hulud-vpc"
  }

}