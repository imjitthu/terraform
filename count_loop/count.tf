resource "aws_vpc" "VPC_Count" {
    cidr_block = "${var.VPC_CIDR}"
    instance_tenancy = "default"
    tags = {
      Name = "test-VPC-Count"
    }
}

#Get Availability Zones from DataSources
data "aws_availability_zones" "AVZ" {
    state = "available"
}

resource "aws_subnet" "subnets" {
  count = "${length(data.aws_availibility_zones.AVZ.names)}"
  availability_zone = "${element(data.aws_availability_zones.AVZ.names, count.index)}"
  #count = "${length(var.AV_ZONES)}"
  vpc_id = "${aws_vpc.VPC_Count.id}"
  cidr_block = "${element(var.SUBNET_CIDR, count.index)}"
  tags = {
    Name = "subnet-1-Count-${count.index+1}"
  }
}