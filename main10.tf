provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "arunkey" {
  key_name   = "arunkey"
  public_key = file("${path.module}/awsk.pub")
}

resource "aws_instance" "name" {
  ami           = "ami-091a2ff533eea416c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.arunkey.key_name
}