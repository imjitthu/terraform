resource "aws_instance" "instance" {
  count = "${length(var.COMPONENT)}"
  ami = data.aws_ami.AMI.id
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "set hostname ${element(var.COMPONENT, count.index)}"
  tags = {
    Name = "${element(var.COMPONENT, count.index)}-${var.ENV}"
  }
}

output "Private_IPs" {
  value = join(",", aws_instance.instance.*.private_ip)
}

output "Component_Names" {
  value = join(",", aws_instance.instance.*.tags.Name)
}