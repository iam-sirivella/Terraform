variable "type"{
    type = string
    default="t3.micro"
}
provider "aws"{
    region="us-east-1"
}
resource "aws_instance" "sample" {
    ami="ami-0ecb62995f68bb549"
    key_name="Hari-Key-pair"
    instance_type=var.type
    subnet_id="subnet-05e5001d7f1539072"
}
output "example_output"{
    value =resource.aws_instance.sample.ami
}
