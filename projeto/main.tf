terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "modulo-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "${var.region}a"
  tags = {
    Name = "modulo-public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.region}b"
  tags = {
    Name = "modulo-private-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "modulo-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.public_rt_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "mod-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_key_pair" "key" {
  key_name   = "mod-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "sg" {
  name        = "mod-sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main.id

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

resource "aws_instance" "ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key.key_name
  vpc_security_group_ids      = [aws_security_group.sg.id]

 root_block_device { #Block que permite a curtomização do tamanho de disco que já vem configurado por padrão
    volume_size = var.volume_size
    volume_type = var.volume_type
 }
 
  tags = {
    Name = "mod-ec2"
  }
}

resource "aws_s3_bucket" "mod_bucket" {
  bucket = "modulo-s3-bucket"
  force_destroy = true
  tags = {
    Name = "mod-s3"
  }
}
