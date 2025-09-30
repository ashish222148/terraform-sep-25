
// Author: Ashish Kumar Singh
// Date: 2025-09-30
// Purpose: Create Windows EC2 instance with RDP access in default VPC
// we are using the same pem key which exist on aws 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}
data "aws_key_pair" "existing" {
  key_name = "ailiya-key" # must match the name in AWS
}
resource "aws_instance" "this" {
  ami           = "ami-0432b8889b74a73e6" # Windows Server AMI
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.existing.key_name

  tags = {
    Name = "Windows-RDP-Instance"
  }
}

output "publicip" {
  value = aws_instance.this.public_ip
}
