
resource "aws_key_pair" "ailiyakey" {
  key_name = "ailiyakey"
  public_key = file("${path.module}/awsk.pub")
}

output "filecontent" {
  value = "${aws_key_pair.ailiyakey.key_name}"
}

provider "aws" {
  region = "ap-south-1"
}