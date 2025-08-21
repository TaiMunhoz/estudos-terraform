# Exporta o ID da VPC criada no módulo rede
output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.vpc-mod.id
}

# Exporta o ID da Subnet pública criada no módulo rede
output "public_subnet_id" {
  description = "ID da subnet pública"
  value       = aws_subnet.subnet_pub_mod.id
}

# Exporta o ID do Security Group criado no módulo rede
output "sg_id" {
  description = "ID do security group"
  value       = aws_security_group.sg.id
}

