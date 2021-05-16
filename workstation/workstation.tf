resource "aws_instance" "${var.COMPONENT}" {
ami = "ami-079a3f3cf00741286"
instance_type = "${var.INSTANCE_TYPE}"
tags = {
  "name" = "WorkStation"
}
}

resource "aws_route53_record" "${var.COMPONENT}" {
  zone_id = "Z077254017HKF6MBGS2JG"
  name = "workstation.jithendar.com"
  type = "A"
  ttl = "300"
  records = [aws_instance.WorkStation.public_ip]
}

output "EC2 Details" {
    value = "aws_instance.${var.COMPONENT}.public_ip"
    description = "Publisc IP of WorkStation"
}