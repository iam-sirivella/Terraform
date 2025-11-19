module "aws_ec2_instance_test" {
    source = "./modules-ec2-s3"
    ami=var.ami
    instance_type=var.instance_type
    bucket_name=var.bucket_name
    dynamo_table_name=var.dynamo_table_name
    my_environment=var.my_environment
    subnet_id=var.subnet_id
    key_name=var.key_name
    instance_name=var.instance_name
}