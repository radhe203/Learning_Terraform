resource "aws_vpc" "tf-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "tf-vpc"
    }
}


resource "aws_subnet" "tf-public-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-public-subnet"
  }
}


resource "aws_subnet" "tf-private-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-public-subnet"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-igw"
  }
}


resource "aws_route_table" "tf-rt" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }
}

resource "aws_route_table_association" "tf-rt-association" {
    subnet_id = aws_subnet.tf-public-subnet.id
    route_table_id = aws_route_table.tf-rt.id
}