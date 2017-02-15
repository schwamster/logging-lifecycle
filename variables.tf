variable "aws_region" {
  default = "eu-central-1"
}

variable "log_group_name" {
  default = "TestLogGroup"

  # default = "/aws/lambda/MoveLogsToS3"
}

#!see naming convetions of buckets - only lower-case characters
variable "bucket_name" {
  default = "8cf434d3-7425-41c2-9201-fc8e8d784a86"
}
