
provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/awsk.pub")
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  dynamic "ingress" {
    for_each = [22, 80, 443, 3389]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "allow_tls"
  }
}

output "securityGroupDetails" {
  value = "${aws_security_group.allow_tls.id}"
}

resource "aws_instance" "main" {
  ami           = "ami-0f9708d1cd2cfee41"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key-tf.key_name
  vpc_security_group_ids  = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "First-ec2-instance"
  }
}