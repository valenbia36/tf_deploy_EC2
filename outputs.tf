output "instance_id" {
    description = "EC2 instance ID"
    value = aws_instance.vb_ec2.id
}
output "instance_public_ip" {
    description = "EC2 instance IP"
    value = aws_instance.vb_ec2.public_ip
}