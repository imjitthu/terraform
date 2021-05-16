resource "aws_instance" "WorkStation" {
ami = "ami-079a3f3cf00741286"
instance_type = "t2.small"
tags = {
  "name" = "WorkStation"
}
}

resource "aws_route53_record" "workstation" {
  zone_id = "Z077254017HKF6MBGS2JG"
  name = "workstation.jithendar.com"
  type = "A"
  ttl = "300"
  records = [aws_instance.WorkStation.public_ip]
}

# resource "aws_route53_record" "alb" {
#   zone_id               = "Z01648193972APZOIN217"
#   name                  = "${var.COMPONENT}-${var.ENV}.jithendar.com"
#   type                  = "CNAME"
#   ttl                   = "300"
#   records               = [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_DNS]
# }