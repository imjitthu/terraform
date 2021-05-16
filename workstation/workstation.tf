resource "aws_instance" "var.COMPONENT" {
ami = "ami-079a3f3cf00741286"
instance_type = "${var.INSTANCE_TYPE}"
tags = {
  "name" = "Work_Station"
}
}

resource "aws_route53_record" "WorkStation" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "workstation.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [aws_instance.WorkStation.public_ip]
}

output "EC2_Details" {
    value = "aws_instance.WorkStation.public_ip"
    description = "Publisc IP of WorkStation"
}