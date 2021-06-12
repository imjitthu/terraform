resource "aws_instance" "instance" {
  count = "${length(var.COMPONENT)}"
  ami = data.aws_ami.AMI.id
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "set hostname ${element(var.COMPONENT, count.index)}"
  tags = {
    #Name = "${var.ENV}"-"${var.COMPONENT.name}"
    Name = "${element(var.COMPONENT, count.index)-(var.ENV)}"
  }
}