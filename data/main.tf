terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Consulta a VPC existente
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["modulo-vpc"]
  }
}

# Consulta a subnet pública pela tag
data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["modulo-public-subnet"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

# Consulta o security group existente
data "aws_security_group" "sg" {
  filter {
    name   = "tag:Name"
    values = ["mod-sg"]
  }
  vpc_id = data.aws_vpc.main.id
}

# Consulta a chave pública existente
data "aws_key_pair" "key" {
  key_name = "mod-key"
}

# Nova instância usando os dados acima
resource "aws_instance" "ec2_data" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.key.key_name
  vpc_security_group_ids      = [data.aws_security_group.sg.id]

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "data-ec2"
  }
}
