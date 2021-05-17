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
    Name = "subnet-count-${count.index+1}"
  }
}

# When count is set, Terraform distinguishes between the block itself and the multiple resource or module instances associated with it. Instances are identified by an index number, starting with 0.

# The syntax is count.index: For example, ${count.index} will interpolate the current index in a multi-count resource.

# element retrieves a single element from a list. The index is zero-based. This function produces an error if used with an empty list. Use the built-in index syntax list[index] in most cases.

# length determines the length of a given list, map, or string. If given a list or map, the result is the number of elements in that collection. If given a string, the result is the number of characters in the string.