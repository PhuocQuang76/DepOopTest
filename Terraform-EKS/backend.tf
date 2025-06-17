terraform {
  backend "s3" {
    bucket = "aileens3-tf-jk-eks" //name of s3 bucket
    key    = "eks/terraform.tfstate"
    region = "us-west-2"
  }
}