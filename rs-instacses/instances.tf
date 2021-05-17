resource "aws_instance" "instances" {
  for_each = toset(var.INSTANCES_LIST)
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  tags = {
    Name = each.value
  }

# connection {
#   type = "ssh"
#   user = "root"
#   password = "${var.PASSWORD}"
#   host = self.private_ip
# }

provisioner "local-exec" {
  when = create
  inline = "sh mkinv.sh"
}
}
