resource "aws_instance" "name" {
  count = "${length(var.COMPONENT)}"
  ami = "${var.AMI}"
  #spot_price = "0.03"
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "set hostname ${element(var.COMPONENT, count.index)}"
  tags = {
      Name = "${element(var.COMPONENT, count.index)}"
  }
}

#cidr_block = "${element(var.SUBNET_CIDR, count.index)}"