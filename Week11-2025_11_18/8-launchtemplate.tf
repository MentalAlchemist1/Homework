resource "aws_launch_template" "shai-hulud-lt" {
  name_prefix   = "shai-hulud-lt"
  image_id      = "ami-06d455b8b50b0de4d"
  instance_type = "t3.micro"

  # key_name = "MyLinuxBox"

  vpc_security_group_ids = [aws_security_group.web_server.id]

  user_data = base64encode(file("user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "shai-hulud-lt"
      Service = "shai-hulud"
      Owner   = "Alex"
      Planet  = "Arrakis"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}