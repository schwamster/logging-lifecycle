resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = "${file("policies/lambda_role.json")}"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "lambdas/move_to_s3.zip"
  function_name    = "move_to_s3"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "exports.test"
  runtime          = "nodejs"
  source_code_hash = "${base64sha256(file("lambdas/move_to_s3.zip"))}"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
