resource "aws_s3_bucket" "hari_priya_bucket_1"{
    bucket= "${var.my_environment}-${var.instance_name}"
}