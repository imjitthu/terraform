variable "a" {
  default = 100
}

output "a" {
  value = var.a
}

## THese variables are three types

# Variable Type - DEFAULT
variable "normal" {
  default = 10
}

# Variable Type - LIST

variable "list" {
  default = [ 100, "abc", true ]
}

## In one list variable you can give multiple values which is of different data types.

output "list" {
  value = var.list
}

output "list_1" {
  value = var.list[0]
}

output "list_2" {
  value = var.list[1]
}

output "list_3" {
  value = var.list[2]
}

# Variable  Type - MAP

variable "map" {
  default = {
    course_name = "DevOps",
    trainer = "Jithendar"
  }
}

output "COURSE_NAME" {
  value = var.map["course_name"]
}

## Variables if we are combining with other strings then those should be given in quotes
# Only thing is , Terraform does not support single quotes any where

output "COURSE" {
  value = "Welcome to ${var.map["course_name"]} Training, Trainer is ${var.map["trainer"]}"
}

