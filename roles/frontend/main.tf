resource "aws_instance" "frontend" {
  # aws_spot_instabce_request for spot instance
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  key_name = "test"
  # spot_type = "one-time"  aws_spot_instance_request
  tags = {
    "Name" = "${var.COMPONENT}-Server"
  }

provisioner "local-exec" {
  command = "ansible-playbook -i ${aws_instance.frontend.private_ip}, ansible_user=root ansible_password=DevOps321 ${var.PASSWORD} /var/lib/jenkins/workspace/rs-tf-app/${var.COMPONENT}.yml"
}
}

resource "aws_route53_record" "frontend" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "${var.COMPONENT}.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_instance.frontend.public_ip ]
}

output "Frontend_PIP" {
  value = aws_instance.frontend.public_ip
}