data "terraform_remote_state" "rs-projecy" {
  backend           = "s3"
  config            = {
    bucket          = "terraform-state-jithendar"
    key             = "rs-instances/terraform.tfstate"
    region          = "us-east-1"
  }
}