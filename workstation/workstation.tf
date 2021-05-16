resource "aws_instance" "WorkStation" {
ami = "ami-079a3f3cf00741286"
instance_type = "t2.small"
tags = {
  "name" = "WorkStation"
}
}

resource "aws_route53_record" "workstation" {
  zone_id = "Z077254017HKF6MBGS2JG"
  name = "jithendar.com"
  type = "A"
  ttl = "300"
  records = [aws_instance.workstation.public_ip]
}