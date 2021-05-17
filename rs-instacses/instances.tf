resource "aws_instance" "instances" {
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
  when = create
  inline = [
     "set-hostname frontend",
     "yum install nginx -y",
    ]  
}
}

output "instance_private_ip_addresses" {
  # Result is a map from instance id to private IP address, such as:
  #  {"i-1234" = "192.168.1.2", "i-5678" = "192.168.1.5"}
  value = {
    for instance in aws_instance.instances:
    instance.id => instance.public_ip
  }