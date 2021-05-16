resource "aws_instance" "sample" {
  ami                       = "ami-052ed3344670027b3"
  instance_type             = "t3.micro"
  tags                      = {
        Name                = upper(var.name)
  }

}

variable "name" {
  default = "sample"
}

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

provider "aws" {
  region = "us-east-1"
}