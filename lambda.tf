resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = "${file("policies/lambda_role.json")}"
}

resource "aws_iam_role_policy" "iam_for_lambda_policy" {
  name   = "iam_for_lambda_policy"
  role   = "${aws_iam_role.iam_for_lambda.id}"
  policy = "${file("policies/lambda_permission.json")}"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "lambdas/MoveLogsToS3.zip"
  function_name = "MoveLogsToS3"
  role          = "${aws_iam_role.iam_for_lambda.arn}"

  handler = "MoveLogsToS3::MoveLogsToS3.Function::FunctionHandler"

  #handler = "MoveLogsToS3.handler"
  timeout = 20

  # runtime = "nodejs4.3"

  runtime          = "dotnetcore1.0"
  source_code_hash = "${base64sha256(file("lambdas/MoveLogsToS3.zip"))}"
  environment {
    variables = {
      bucket = "${var.bucket_name}"
    }
  }
}

resource "aws_lambda_event_source_mapping" "log_kinesis_lambda_mapping" {
  batch_size        = 10
  event_source_arn  = "${aws_kinesis_stream.log_stream.arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.test_lambda.arn}"
  starting_position = "TRIM_HORIZON"
}
