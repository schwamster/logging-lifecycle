# Output the ID of the RDS instance
output "kinesis_stream_id" {
  value = "${aws_kinesis_stream.log_stream.id}"
}

output "kinesis_stream_arn" {
  value = "${aws_kinesis_stream.log_stream.arn}"
}

output "kinesis_stream_name" {
  value = "${aws_kinesis_stream.log_stream.name}"
}

output "log_to_kinesis_id" {
  value = "${aws_iam_role.log_to_kinesis.unique_id}"
}

output "log_to_kinesis_arn" {
  value = "${aws_iam_role.log_to_kinesis.arn}"
}
