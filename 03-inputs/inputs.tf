# Inputs should be loaded in variables

# Thats why we need to declare a empty variable in terraform

variable "abc" {
  type = number
}

# Input type - After terraform apply execution
output "abc" {
  value = var.abc
}

# Input type as a argument
variable "abc1" {}
output "abc1" {
  value = var.abc1
}

# Input type from a file, terraform.tfvars
variable "abc2" {}
output "abc2" {
  value = var.abc2
}


# Input from file, sample.auto.tfvars
variable "abc3" {}
output "abc3" {
  value = var.abc3
}

# Input from SHELL ENV variables
# export TF_VAR_abc4="Hello abc4"

variable "abc4" {}

output "abc4" {
  value = var.abc4
}
