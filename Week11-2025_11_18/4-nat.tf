resource "aws_eip" "nat" {

  tags = {
    Name = "shai_hulud_nat_eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-west-2a.id

  tags = {
    Name = "shai_hulud_nat"
  }

  depends_on = [aws_internet_gateway.igw]
}