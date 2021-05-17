resource "aws_vpc" "VPC_FOR_EACH" {
    for_each = var.CIDR_MAP
    cidr_block = each.value
  tags = {
    Name = each.key
  }
}


# for_each is a meta-argument and can be used with modules and with every resource type. For_each accepts a map or a set of strings, and creates an instance for each item in that map or set.

# toset: Pass a list value to toset to convert it to a set, which will remove any duplicate elements and discard the ordering of the elements. Ex: for_each = toset(var.CIDR_LIST)