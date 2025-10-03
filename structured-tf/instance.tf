resource "aws_instance" "main" {
  ami                    = var.image-id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "First-ec2-instance"
  }
}