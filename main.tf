provider "aws" {
  # log in with aws cli, then terraform will automatically pick up the tokens required
  # see https://www.terraform.io/docs/providers/aws/index.html authentification 
  region = "${var.aws_region}"
}
