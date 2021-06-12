resource "aws_spot_instance_request" "instance" {
  count = "${length(var.COMPONENT)}"
  ami = data.aws_ami.AMI.id
  spot_price = "0.03"
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "set hostname ${element(var.COMPONENT, count.index)}"
  tags = {
    Name = "${var.ENV}"
    #Name = "${element(var.COMPONENT, count.index)}"-"${var.ENV} + 1"
  }
}

#cidr_block = "${element(var.SUBNET_CIDR, count.index)}"