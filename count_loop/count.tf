resource "aws_vpc" "VPC_Count" {
    cidr_block = "${var.VPC_CIDR}"
    instance_tenancy = "default"
    tags = {
      Name = "test-VPC-Count"
    }
}

resource "aws_subnet" "subnets" {
  count = "${length(data.aws_availability_zones.avz.names)}"
  #count = "${length(var.avz)}"
  availability_zone = "${element(data.aws_availability_zones.avz.names, count.index)}"
  vpc_id = "${aws_vpc.VPC_Count.id}"
  cidr_block = "${element(var.SUBNET_CIDR, count.index)}"
  tags = {
    Name = "subnet-1-Count-${count.index+1}"
  }
}