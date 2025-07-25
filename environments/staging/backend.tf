terraform {
  backend "s3" {
    bucket         = "my-tf-backend"
    key            = "staging/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "my-tf-locks"
  }
}