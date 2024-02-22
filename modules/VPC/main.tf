
/* The aws_vpc resource creates the VPC. AWS by default creates NACL, Security Group and route table (local) when you create a VPC.
We still create new route table as we need connection to IGW.
The aws_subnet resource creates a public subnet with the map_public_ip_on_launch attribute set to true.
The aws_route_table resource creates a route table with a default route pointing to an Internet Gateway.
The aws_route_table_association resource associates the route table with the public subnet.
The aws_internet_gateway resource creates an internet gateway and associates it with the VPC. */


resource "aws_vpc" "main"{
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-VPC"
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_cidr_block  
  availability_zone       = var.AZ_subnet_public 
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env_prefix}-subnet_public"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_private_cidr_block 
  availability_zone       = var.AZ_subnet_private 
  tags = {
    Name = "${var.env_prefix}-subnet_private"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id  
  }
  tags = {
    Name = "${var.env_prefix}-rtb"
  }
}

resource "aws_route_table_association" "public_route_association" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.public_route_table.id
} #explicitly associating a subnet with a route table that allows traffic to flow to the internet through an Internet Gateway.

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}
