resource "aws_launch_template" "shadowtitan-lt" {
  name_prefix   = "shadowtitan-lt"
  image_id      = "ami-02b297871a94f4b42" # Amazon Linux 2 AMI in us-west-2
  instance_type = "t3.micro"

  # key_name = "MyLinuxBox"

  vpc_security_group_ids = [aws_security_group.shadowtitan-sg.id]

  user_data = filebase64("user_data.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "shadowtitan-lt"
      Service = "shadowtitan"
      Owner   = "Alex"
      Planet  = "Arrakis"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}