resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = "${file("policies/lambda_role.json")}"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "lambdas/MoveLogsToS3.zip"
  function_name = "MoveLogsToS3"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "MoveLogsToS3::MoveLogsToS3.Function::FunctionHandler"

  runtime = "dotnetcore1.0"

  #runtime          = "nodejs4.3"
  source_code_hash = "${base64sha256(file("lambdas/MoveLogsToS3.zip"))}"

  environment {
    variables = {
      bucket = "${var.bucket_name}"
    }
  }
}
