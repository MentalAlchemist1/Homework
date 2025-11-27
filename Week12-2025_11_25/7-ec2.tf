# resource "aws_instance" "web-server" {
#   ami                         = "ami-06d455b8b50b0de4d" # Amazon Linux 2023 AMI ID for us-west-2
#   associate_public_ip_address = true
#   instance_type               = "t3.micro"
#   # key_name = 
#   subnet_id              = aws_subnet.public-us-west-2a.id
#   vpc_security_group_ids = [aws_security_group.web_server.id]

#   user_data = file("user_data.sh")

#   tags = {
#     Name = "shai_hulud_web-server"
#   }
# }