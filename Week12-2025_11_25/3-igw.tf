resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.shadowtitan_vpc.id

  tags = {
    Name    = "shadowtitan_IGW"
    Service = "thewatcherapp1"
    Owner   = "AlexA"
    Planet  = "Arrakis"
  }
}