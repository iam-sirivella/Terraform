provider "aws" {
  region = "us-east-1"
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "example_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "./keys/key-pair-project.pem"
}

resource "aws_key_pair" "example_key_pair" {
  key_name   = "key-pair-project"
  public_key = tls_private_key.rsa.public_key_openssh

  tags = {
    Environment     = "DEV"
    Creation_Method = "Terraform"
    Name            = "key-pair-project"
  }
}