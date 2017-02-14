provider "aws" {
  # log in with aws cli, then terraform will automatically pick up the tokens required
  # see https://www.terraform.io/docs/providers/aws/index.html authentification 
  region = "${var.aws_region}"
}

resource "aws_kinesis_stream" "log_stream" {
  name             = "terraform-kinesis-log"
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags {
    Environment = "test"
  }
}

resource "aws_iam_role" "log_to_kinesis" {
  name               = "log_to_kinesis_role"
  assume_role_policy = "${format(file("policies/log_to_kinesis_role.json"), var.aws_region)}"
}

resource "aws_iam_role_policy" "log_to_kinesis_policy" {
  name   = "log_to_kinesis_policy"
  role   = "${aws_iam_role.log_to_kinesis.id}"
  policy = "${format(file("policies/log_to_kinesis_permission.json"),aws_kinesis_stream.log_stream.arn, aws_iam_role.log_to_kinesis.arn )}"
}

resource "aws_cloudwatch_log_subscription_filter" "kinesis_logfilter" {
  name            = "kinesis_logfilter"
  role_arn        = "${aws_iam_role.log_to_kinesis.arn}"
  log_group_name  = "${var.log_group_name}"
  filter_pattern  = "{$.userIdentity.type = Root}"
  destination_arn = "${aws_kinesis_stream.log_stream.arn}"
}
