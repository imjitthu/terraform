resource "aws_instance" "name" {
  count = "${length(var.COMPONENT)}"
  #ami = "${var.AMI}"
  ami = data.aws_ami.AMI.id
  #spot_price = "0.03"
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "set hostname ${element(var.COMPONENT, count.index)}"
  tags = {
    Name = "${var.ENV}" count.index + 1
    #Name = "${element(var.COMPONENT, count.index)}"-"${var.ENV} + 1"
  }
}

#cidr_block = "${element(var.SUBNET_CIDR, count.index)}"