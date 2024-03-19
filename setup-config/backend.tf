terraform {
  backend "s3" {
    bucket = "sockshop"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
