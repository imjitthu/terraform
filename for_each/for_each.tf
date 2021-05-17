resource "aws_vpc" "VPC_FOR_EACH" {
    for_each = var.CIDR_FOR_EACH
    cidr_block = each.value
  
}


# for_each (meta argument) helps in creating multiple resources with multiple values at single time.