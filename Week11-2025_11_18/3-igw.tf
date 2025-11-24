resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "shai_hulud_IGW"
    Service = "thewatcherapp1"
    Owner   = "AlexA"
    Planet  = "Arrakis"
  }
}