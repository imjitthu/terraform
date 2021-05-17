resource "aws_vpc" "VPC_FOR_EACH" {
    for_each = var.CIDR_MAP
    cidr_block = each.value
  tags = {
    Name = each.key
  }
}


# for_each (meta argument) helps in creating multiple resources with multiple values at single time.

# toset function used for list variable ex: for_each = toset(var.CIDR_LIST)