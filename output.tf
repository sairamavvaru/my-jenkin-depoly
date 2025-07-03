output "instance_public_ip" {
  description = "Public IP of your EC2 instance"
  value       = aws_instance.web.public_ip
}

output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.web.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}
