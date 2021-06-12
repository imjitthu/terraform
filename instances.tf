resource "aws_instance" "instance" {
  count   = length(var.COMPONENT)
  ami = data.aws_ami.AMI.id
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "set hostname ${element(var.COMPONENT, count.index)}"
  tags = {
    Name = "${element(var.COMPONENT, count.index)}-${var.ENV}"
  }
}

output "ami" {
  value = aws_instance.instance[*].private_ip
}

output "Component" {
  value = var.COMPONENT
}

resource "aws_route53_record" "roboshop" {
  for_each = var.COMPONENT
  toset    = var.COMPONENT
  #count =    length(var.COMPONENT)
  allow_overwrite = true
  zone_id    = data.aws_route53_zone.jithendar.zone_id
  name       = each.value.data.aws_route53_zone.jithendar.name
  type       = "A"
  ttl        = "300"
  records    = each.value.private_ip
}

