data "terraform_remote_state" "rs-project" {
  backend           = "s3"
  config            = {
    bucket          = "terraform-state-jithendar"
    key             = "rs-instances/mysql.tfstate"
    region          = "us-east-1"
  }
}