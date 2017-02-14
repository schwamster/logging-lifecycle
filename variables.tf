variable "aws_region" {
  default = "eu-central-1"
}

variable "log_group_name" {
  default = "TestLogGroup"
}

#!see naming convetions of buckets - only lower-case characters
variable "bucket_name" {
  default = "logbucket"
}
