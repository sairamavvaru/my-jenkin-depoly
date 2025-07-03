    # Example Terraform configuration (AWS)
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
    }

    provider "aws" {
      region = "us-west-2" # Choose your region
    }

    resource "aws_vpc" "main" {
      cidr_block = "10.0.0.0/16"
    }

    resource "aws_subnet" "public" {
      vpc_id     = aws_vpc.main.id
      cidr_block = "10.0.1.0/24"
      availability_zone = "us-west-2a"
    }

    resource "aws_subnet" "private" {
      vpc_id     = aws_vpc.main.id
      cidr_block = "10.0.2.0/24"
      availability_zone = "us-west-2b"
    }

    resource "aws_security_group" "webserver" {
      name        = "webserver-sg"
      description = "Allow inbound traffic to web server"
      vpc_id      = aws_vpc.main.id

      ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      ingress {
        from_port   = 443
        to_port     = 443
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


    resource "aws_instance" "web" {
      ami                    = "ami-0c55b1e8d9a3702a1" # Replace with your AMI
      instance_type          = "t2.micro"
      subnet_id              = aws_subnet.public.id
      vpc_security_group_ids = [aws_security_group.webserver.id]
      key_name = "your-key-pair" # Replace with your key pair

      user_data = <<EOF
          #!/bin/bash
          sudo apt-get update
          sudo apt-get install -y nginx
          echo "<h1>Hello, World!</h1>" | sudo tee /var/www/html/index.html
          sudo systemctl start nginx
        EOF

    }