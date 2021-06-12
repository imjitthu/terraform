resource "aws_instance" "instance" {
  count   = length(var.COMPONENT)
  ami = data.aws_ami.AMI.id
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "set hostname ${element(var.COMPONENT, count.index)}"
  tags = {
    Name = "${element(var.COMPONENT, count.index)}-${var.ENV}"
  }
}


resource "aws_route53_record" "roboshop" {
  dynamic route {
    for_each   = var.COMPONENT
    zone_id    = data.aws_route53_zone.jithendar.zone_id
    name       = "${element(var.COMPONENT)}".data.aws_route53_zone.jithendar.name
    type       = "A"
    ttl        = "300"
    records    = "${element(aws_instance.instance)}".private_ip
}
}

