resource "aws_instance" "var.ec2_instances" {
ami = "ami-079a3f3cf00741286"
instance_type = "t2.small"
tags = {
  "name" = "var.ec2_instances"
}
}

resource "aws_route53_record" "www" {
  zone_id = "Z077254017HKF6MBGS2JG"
  name = "workstation.jithendar.com"
  type = "A"
  ttl = "300"
  records = [aws_instance.workstation.public_ip]
}