provider "aws"{
    region="us-east-1"
}
resource "aws_instance" "sample" {
    ami="ami-0ecb62995f68bb549"
    key_name="Hari-Key-pair"
    instance_type="t3.micro"
    subnet_id="subnet-05e5001d7f1539072"
}
