// Author: Ashish Kumar Singh
// Date: 2025-09-30
// Purpose: Create Windows EC2 instance with RDP access in default VPC
// create security group and attached to default vpc


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

data "aws_key_pair" "name" {
  region   = "ap-south-1"
  key_name = "ailiya-key"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "asg" {
  name   = "vpcsg"
  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nysg"
  }
}

resource "aws_instance" "name" {
  ami           = "ami-0432b8889b74a73e6" # Windows Server AMI
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.name.key_name
}