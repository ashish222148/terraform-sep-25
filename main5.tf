// Author: Ashish Kumar Singh
// Date: 2025-09-30
// Purpose: Create Security group



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

data "aws_vpc" "name" {
  default = true
}

resource "aws_security_group" "asg" {
  name   = "ailiya-security-group"
  vpc_id = data.aws_vpc.name.id
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
  Name="ailiya-sg"
}
}