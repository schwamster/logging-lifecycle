# logging-lifecycle

keywords: aws, terraform, kinesis, lambda, log groups, s3, glacier, sqs

this repo is supposed to provide an example of how to create a log flow. push your log events from the log groups to s3, glacier, and sqs.
all resources will be created with terraform. 

## prequisites

have some event source that pushes logs to a cloud watch log group. an easy example would be cloud trail -> cloud watch see here: http://docs.aws.amazon.com/awscloudtrail/latest/userguide/send-cloudtrail-events-to-cloudwatch-logs.html

## overview

![overview](logging-lifecyle.png)

acknowledgement: diagram made with [draw.io](https://www.draw.io)

