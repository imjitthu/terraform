resource "aws_vpc" "VPC_Count" {
    cidr_block = "190.160.0.0/16"
    instance_tenancy = "default"
    tags = {
      Name = "test-VPC-Count"
    }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = "${aws_vpc.test-VPC-count.id}"
  cidr_block = "190.160.1.0/24"
  tags = {
    Name = "subnet-1-Count"
  }
}