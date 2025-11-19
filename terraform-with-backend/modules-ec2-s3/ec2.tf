resource "aws_instance" "sample_ec2_test"{
    count = 2
    ami=var.ami
    subnet_id = var.subnet_id
    key_name = var.key_name
    instance_type = var.instance_type
    associate_public_ip_address = true
    tags = {
        Name = "${var.my_environment}-${var.instance_name}"
    }
}