resource "local_file" "foo" {
  content     = var.PUBLIC_IP
  filename = "/tmp/publicip.txt"
}

variable "PUBLIC_IP" {}