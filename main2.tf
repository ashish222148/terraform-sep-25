// Author: Ashish Kumar Singh
// Date: 2025-09-30
// Purpose: Create Windows EC2 instance with RDP access in default VPC
// we are creating a public key and pusing on the server
//openssl genrsa -out my-key.pem 2048
//ssh-keygen -y -f my-key.pem > my-key.pub

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

resource "aws_key_pair" "windows_key" {
  key_name   = "windows-key"
  public_key = file("./my-key.pub")
}

resource "aws_instance" "ailiya-public-srv" {
  region        = "ap-south-1"
  ami           = "ami-0432b8889b74a73e6"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.windows_key.key_name
  tags = {
    Name = "ashish_pub"
  }
}
output "publicoip" {
  value = aws_instance.ailiya-public-srv.public_ip
}