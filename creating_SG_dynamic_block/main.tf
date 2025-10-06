resource "aws_security_group" "ailiya-SG" {
  name        = "Ailiya-SG"
  description = "this is the security group for ailiya"

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value.from_port
      to_port     = try(port.value.to_port, port.value.from_port)
      protocol    = "tcp"
      cidr_blocks = port.value.cidr
    }
  }
}
output "listofports" {
  value = [for key, value in aws_security_group.ailiya-SG.ingress: value.from_port]
}
