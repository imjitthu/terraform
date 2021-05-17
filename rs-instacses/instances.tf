resource "aws_instance" "rs-instances" {
  for_each = toset(var.INSTANCES_LIST)
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCES}"
  tags = {
    Name = each.value
  }
}