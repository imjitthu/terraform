provider "aws" {
  version = "~> 3.0"
  region = "us-east-1"
}

resource "aws_instance" "var.instance" {
ami = "ami-079a3f3cf00741286"
instance_type = "t2.small"
tags = {
  "name" = "var.instance"
}
}