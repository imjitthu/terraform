resource "aws_instance" "rs-instances" {
  for_each = toset(var.INSTANCES_LIST)
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  tags = {
    Name = each.value
  }

connection {
  type = "ssh"
  user = "root"
  password = "${var.PASSWORD}"
  host = self.private_ip
}

provisioner "remote-exec" {
  when = each.value == frontend
  inline = [
     "set-hostname frontend",
     "yum install nginx -y",
    ]  
}
}