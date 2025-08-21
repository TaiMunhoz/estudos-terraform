variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "public_rt_cidr" {
  default = "0.0.0.0/0"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-020cba7c55df1f615" # Ubuntu Server 22.04 LTS (exemplo)
}

variable "public_key_path" {
  default = "~/.ssh/terraform-key.pub"
}

#tamanho de disco
variable "volume_size" {
  type        = number
  default     = 8
}

#tipo do disco
variable "volume_type" {
  type        = string
  default     = "gp3"
}
