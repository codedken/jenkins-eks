terraform {
  backend "s3" {
    bucket = "sockshop"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
