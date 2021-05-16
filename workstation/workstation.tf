resource "aws_instance" "WorkStation" {
ami = "ami-079a3f3cf00741286"
instance_type = "${var.INSTANCE_TYPE}"
associate_public_ip_address = true
tags = {
  "name" = "${var.COMPONENT}"
}
}

output "EC2_Public_IP" {
    value = aws_instance.WorkStation.public_ip
    description = "Publisc IP of WorkStation"
}
output "EC2_instance_id" {
  value       = aws_instance.${var.COMPONENT}.id
  description = "EC2 Instance ID"
}

resource "aws_route53_record" "WorkStation" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "workstation.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_instance.WorkStation.public_ip ]
}