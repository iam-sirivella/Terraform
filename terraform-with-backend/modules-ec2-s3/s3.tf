resource "aws_s3_bucket" "hari_priya_bucket"{
    bucket= "${var.my_environment}-${var.bucket_name}"
}