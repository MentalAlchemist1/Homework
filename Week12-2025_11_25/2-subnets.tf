#These are   for  public

resource "aws_subnet" "public-us-west-2a" {
  vpc_id                  = aws_vpc.shadowtitan_vpc.id
  cidr_block              = "10.225.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-west-2a"
    Service = "thewatcherapp1"
    Owner   = "AlexA"
    Planet  = "Arrakis"
  }
}

resource "aws_subnet" "public-us-west-2b" {
  vpc_id                  = aws_vpc.shadowtitan_vpc.id
  cidr_block              = "10.225.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-west-2b"
    Service = "thewatcherapp1"
    Owner   = "AlexA"
    Planet  = "Arrakis"
  }
}


resource "aws_subnet" "public-us-west-2c" {
  vpc_id                  = aws_vpc.shadowtitan_vpc.id
  cidr_block              = "10.225.3.0/24"
  availability_zone       = "us-west-2c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-west-2c"
    Service = "thewatcherapp1"
    Owner   = "AlexA"
    Planet  = "Arrakis"
  }
}

#these are for private
resource "aws_subnet" "private-us-west-2a" {
  vpc_id            = aws_vpc.shadowtitan_vpc.id
  cidr_block        = "10.225.11.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name    = "private-us-west-2a"
    Service = "thewatcherapp1"
    Owner   = "AlexA"
    Planet  = "Arrakis"
  }
}

resource "aws_subnet" "private-us-west-2b" {
  vpc_id            = aws_vpc.shadowtitan_vpc.id
  cidr_block        = "10.225.12.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name    = "private-us-west-2b"
    Service = "thewatcherapp1"
    Owner   = "AlexA"
    Planet  = "Arrakis"
  }
}


resource "aws_subnet" "private-us-west-2c" {
  vpc_id            = aws_vpc.shadowtitan_vpc.id
  cidr_block        = "10.225.13.0/24"
  availability_zone = "us-west-2c"

  tags = {
    Name    = "private-us-west-2c"
    Service = "thewatcherapp1"
    Owner   = "AlexA"
    Planet  = "Arrakis"
  }
}