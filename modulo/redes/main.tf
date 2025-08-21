resource "aws_vpc" "vpc-mod" {
  cidr_block = var.vpc_cidr #variavel
  tags = {
    Name = "modulo-vpc" #nome na AWS
  }
}

resource "aws_subnet" "subnet_priv_mod" {
  vpc_id     = aws_vpc.vpc-mod.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-priv-modulo"
  }
}

resource "aws_subnet" "subnet_pub_mod" {
  vpc_id     = aws_vpc.vpc-mod.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-pub-modulo"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-mod.id
  tags = {
    Name = "modulo-igw"
  }
}

resource "aws_route_table" "public_rt_mod" {
  vpc_id = aws_vpc.vpc-mod.id
  route {
    cidr_block = var.public_rt_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "mod-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.subnet_pub_mod.id
  route_table_id = aws_route_table.public_rt_mod.id
}

resource "aws_security_group" "sg" {
  name        = "mod-sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.vpc-mod.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mod-sg"
  }
}

