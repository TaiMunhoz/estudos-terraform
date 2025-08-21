# ID da Subnet Pública (saída do módulo de rede)
variable "subnet_pub_mod" {
  description = "Subnet pública onde a instância será criada"
  type        = string
}

# Security Group ID (saída do módulo de rede)
variable "sg" {
  description = "Security Group a ser usado na EC2"
  type        = string
}

# Nome da chave SSH
variable "key_name" {
  description = "Nome do par de chaves existente no AWS"
  type        = string
}

# ID da AMI da instância EC2
variable "ami" {
  description = "AMI da instância EC2 (ex: Ubuntu, Amazon Linux)"
  type        = string
}

# Tipo da instância (ex: t2.micro)
variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

# Tamanho do volume EBS em GB
variable "volume_size" {
  description = "Tamanho do volume EBS em GB"
  type        = number
  default     = 8
}

# Tipo do volume EBS
variable "volume_type" {
  description = "Tipo do volume EBS"
  type        = string
  default     = "gp3"
}
