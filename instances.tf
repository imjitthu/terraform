resource "aws_instance" "instance" {
  count   = length(var.COMPONENT)
  ami = "${data.aws_ami.AMI.id}"
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "set hostname ${element(var.COMPONENT, count.index)}"
  tags = {
    Name = "${element(var.COMPONENT, count.index)}-${var.ENV}"
  }
}

resource "null_resource" "make_inv" {
  count   = length(aws_instance.instance)
  provisioner "local-exec" {
    command = "echo ${element(aws_instance.instance, count.index).private_ip} ${element(var.COMPONENT, count.index)} >> inv; ansiple-playbook -U 'https://github.com/imjitthu/Ansible.git' -i inv Ansible/roboshop.yml"
  }
}

resource "aws_route53_record" "roboshop" {
  count = length(var.COMPONENT)
  allow_overwrite = true
  name       = "${element(var.COMPONENT, count.index)}.${data.aws_route53_zone.jithendar.name}"
  zone_id    = "${data.aws_route53_zone.jithendar.zone_id}"
  type       = "A"
  ttl        = "300"
  records    = ["${element(aws_instance.instance, count.index)}".private_ip]
}

