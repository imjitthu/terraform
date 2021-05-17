resource "aws_vpc" "VPC_Count" {
    cidr_block = "${var.VPC_CIDR}"
    instance_tenancy = "default"
    tags = {
      Name = "test-VPC-Count"
    }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = "${aws_vpc.test-VPC-count.id}"
  cidr_block = "${var.SUBNET_CIDR}"
  tags = {
    Name = "subnet-1-Count"
  }
}