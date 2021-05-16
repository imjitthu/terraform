resource "aws_instance" "var.ec2_instances" {
ami = "ami-079a3f3cf00741286"
instance_type = "t2.small"
tags = {
  "name" = "var.ec2_instances"
}
}