# logging-lifecycle

keywords: aws, terraform, kinesis, lambda, log groups, s3, glacier, sqs

this repo is supposed to provide an example of how to create a log flow. push your log events from the log groups to s3, glacier, and sqs.
all resources will be created with terraform. 

## prerequisites

either install aws-cli and sign in or create or use an existing ssh key and you can then run the terraform scripts directly. Otherwise you add the keys in main.tf as explained here: [terraform docs](https://www.terraform.io/docs/providers/aws/index.html)
have some event source that pushes logs to a cloud watch log group. an easy example would be cloud trail -> cloud watch see here: http://docs.aws.amazon.com/awscloudtrail/latest/userguide/send-cloudtrail-events-to-cloudwatch-logs.html

## getting started

make sure you somehow provide authentification (see prerequisites).

update variables.tf with your settings:

* aws_region: region you want to use
* log_group_name: log group that is used as the source for the events that will be pushed to kinesis

then run:

    terraform plan

to check out what resources would be created

then run: 

    terraform apply

to create the resources (this can take a couple of minutes)


if you want to destroy the resources run:

    terraform destroy


## overview

![overview](logging-lifecyle.png)

acknowledgement: diagram made with [draw.io](https://www.draw.io)


## disclaimer

running this terraform script is most likly going to cost you some money just as it would cost you money to create those resources via aws-cli, the console or other means.
