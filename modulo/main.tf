# Módulo de redes
module "rede" {
  source = "./Modulo/redes"
}

# Módulo de EC2
module "ec2" {
  source = "./Modulo/ec2"

  ami             = "ami-020cba7c55df1f615"     # Exemplo: Ubuntu 20.04
  instance_type   = "t2.micro"
  key_name        = "key"           # Nome da chave que você já criou na AWS

  subnet_pub_mod  = module.rede.public_subnet_id
  sg              = module.rede.sg_id
}
