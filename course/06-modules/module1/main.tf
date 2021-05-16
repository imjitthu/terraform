resource "aws_instance" "sample" {
  ami                       = "ami-052ed3344670027b3"
  instance_type             = var.INSTANCE_TYPE
}

resource "aws_instance" "sample1" {
  ami                       = "ami-052ed3344670027b3"
  instance_type             = "t3.micro"
}

variable "INSTANCE_TYPE" {}

output "PUBLIC_IP" {
  value = aws_instance.sample.public_ip
}