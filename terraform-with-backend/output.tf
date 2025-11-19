output "outputval"{
    value=aws.instance.sample_ec2_test[*].public_ip
}