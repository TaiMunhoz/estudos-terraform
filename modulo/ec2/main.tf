# Criação da instância EC2
resource "aws_instance" "ec2" {
  ami                    = var.ami                   # AMI da instância (ex: Ubuntu, Amazon Linux)
  instance_type          = var.instance_type         # Tipo da instância (ex: t2.micro)
  subnet_id              = var.subnet_pub_mod        # Vem como variável (saída do módulo redes)
  associate_public_ip_address = true                 # Garante IP público
  key_name               = var.key_name              # Nome do par de chaves existente
  vpc_security_group_ids = [var.sg]                  # Security Group vindo do módulo redes

  # Root Block para customização do disco
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = "mod-ec2"
  }
}
