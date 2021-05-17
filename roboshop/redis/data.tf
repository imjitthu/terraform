terraform {
  backend "s3" {
    bucket = "terraform-state-jithendar"
    key    = "rs-instances/${var.COMPONENT}.tfstate"
    region = "us-east-1"
  }
}