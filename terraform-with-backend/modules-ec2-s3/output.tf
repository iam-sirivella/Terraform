output "outputval"{
    value = aws_instance.sample_ec2_test[*].public_ip
}