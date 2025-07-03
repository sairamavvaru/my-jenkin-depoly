output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "instance_public_sg" {
  value = aws_instance.web.security_groups[0]
}
