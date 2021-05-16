resource "aws_instance" "WorkStation" {
ami = "ami-079a3f3cf00741286"
instance_type = "${var.INSTANCE_TYPE}"
tags = {
  "name" = "${var.COMPONENT}"
}
}

resource "aws_route53_record" "WorkStation" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "workstation.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  record = "aws_instance.${var.COMPONENT}.public_ip"
}

output "EC2_Details" {
    value = "aws_instance.${var.COMPONENT}.public_ip"
    description = "Publisc IP of WorkStation"
}