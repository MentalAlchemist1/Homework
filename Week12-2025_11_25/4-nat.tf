resource "aws_eip" "shadowtitan-nat-eip" {

  tags = {
    Name = "shadowtitan_nat_eip"
  }
}

resource "aws_nat_gateway" "shadowtitan-nat" {
  allocation_id = aws_eip.shadowtitan-nat-eip.id
  subnet_id     = aws_subnet.public-us-west-2a.id

  tags = {
    Name = "shadowtitan_nat"
  }

  depends_on = [aws_internet_gateway.igw]
}