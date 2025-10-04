resource "aws_instance" "main" {
  ami                    = var.image-id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  user_data = file("${path.module}/script.sh")

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("${path.module}/awsk")
      # host = "${aws_instance.main.public_ip}"
      host = "${self.public_ip}"
    # note: as in the same resource block, aws_instance depend on aws_instance , so to avoid dead lock 
    }

     provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

    provisioner "file" {
    content = "this is test content"
    destination = "/tmp/content.txt"
    }

  tags = {
    Name = "First-ec2-instance"
  }
}