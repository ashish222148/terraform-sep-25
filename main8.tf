terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}
locals {
}

provider "aws" {
  region = "ap-south-1"
}


data "aws_vpc" "name" {
  default = true
}
data "aws_key_pair" "existing" {
  key_name = "ailiya-key" # must match the name in AWS
}

resource "aws_instance" "publlic-instance" {
  region                 = "ap-south-1"
  ami                    = "ami-091a2ff533eea416c"
  availability_zone      = "ap-south-1a"
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.existing.key_name
  vpc_security_group_ids = [aws_security_group.asg.id]
  tags = {
    Name = "TF_Managed"
  }
}

resource "aws_security_group" "asg" {
  name   = "ailiya-sg"
  vpc_id = data.aws_vpc.name.id

  tags = {
    Name = "Ailiya-SG"
  }
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

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1a"
  size              = 10

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.publlic-instance.id
}
