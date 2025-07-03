variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "key_pair_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "webdeploy-key"
}

variable "public_key_path" {
  description = "Absolute path to your SSH public key"
  type        = string
  default     = "/c/Users/user/.ssh/webdeploy.pub"
}


variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}
