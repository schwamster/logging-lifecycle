provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region     = "eu-central-1"
}

resource "aws_instance" "example" {
  ami           = "ami-5aee2235"
  instance_type = "t2.micro"
}