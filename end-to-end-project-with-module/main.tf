module "ec2_instance" {
  source = "./modules/ec2"
  ami_val           = var.ami_val
  subnet_id     = var.subnet_id
  key_val      = var.key_val
  instance_type = var.instance_type
  
}