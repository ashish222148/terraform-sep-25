// Author: Ashish Kumar Singh
// Date: 2025-09-30
// Purpose: Create Security group-recommanded 



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
  tags = {
    Name = "Ailiya-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh-rule" {
  security_group_id = aws_security_group.asg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "rdp-rule" {
  security_group_id = aws_security_group.asg.id
  from_port         = 3389
  to_port           = 3389
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.asg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}