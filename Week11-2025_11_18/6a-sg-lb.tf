# for web server only
resource "aws_security_group" "web_server-lb" {
  name        = "web_server-lb"
  description = "Allow HTTP and SSH - inbound and outbound for web server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web-server-sg-lb"
    Tier = "web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http-lb" {
  description = "http from anywhere"
  security_group_id = aws_security_group.web_server-lb.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80

    tags = {
      Name = "HTTP-inbound-rule"

    }
}

# resource "aws_vpc_security_group_ingress_rule" "ssh" {
#   security_group_id = aws_security_group.web_server-lb.id
#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 22
#   ip_protocol = "tcp"
#   to_port     = 22
# }
 
resource "aws_vpc_security_group_egress_rule" "egress-lb" {
  security_group_id = aws_security_group.web_server-lb.id
  description = "Allow all outbound traffic"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


