provider "aws" {
    region = "us-east-1"
}
module "ec2-s3-instance" {
  source = ".//module/ec2"
  ami = var.ami
  subnet_id=var.subnet_id
  instance_type=var.instance_type
  bucket = var.bucket
}