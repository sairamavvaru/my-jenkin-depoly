provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a" # Amazon Linux 2 AMI for us-east-1
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data     = file("user-data.sh")

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    Name = "web-server"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}
