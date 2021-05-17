resource "aws_vpc" "VPC_Count" {
    cidr_block = "${var.VPC_CIDR}"
    instance_tenancy = "default"
    tags = {
      Name = "test-VPC-Count"
    }
}

resource "aws_subnet" "subnet-1" {
  availability_zone = "${length(data.aws_availability_zones.AV_ZONES.names, count.index)}"
  #count = "${length(var.AV_ZONES)}"
  count = "${length(data.aws_availibility_zones.AV_ZONES.names)}"
  vpc_id = "${aws_vpc.test-VPC-count.id}"
  cidr_block = "${element(var.SUBNET_CIDR, count.index)}"
  tags = {
    Name = "subnet-1-Count-${count.index+1}"
  }
}