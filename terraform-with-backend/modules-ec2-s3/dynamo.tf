resource "aws_dynamodb_table" "my_table"{
    name= "${var.my_environment}-${var.dynamo_table_name}"
    billing_mode ="PAY_PER_REQUEST"
    hash_key="UserID"
    attribute {
        name="UserID"
        type="S"
    }
}