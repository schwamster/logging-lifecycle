provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region = "${var.aws_region}"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "one" {
  vpc_id            = "${aws_security_group.allow_all.vpc_id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_az1}"

  tags {
    Name = "One"
  }
}

resource "aws_subnet" "two" {
  vpc_id            = "${aws_security_group.allow_all.vpc_id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_az2}"

  tags {
    Name = "Two"
  }
}

resource "aws_db_instance" "main_rds_instance" {
  identifier        = "${var.rds_instance_name}"
  allocated_storage = "${var.rds_allocated_storage}"
  engine            = "${var.rds_engine_type}"
  engine_version    = "${var.rds_engine_version}"
  instance_class    = "${var.rds_instance_class}"

  # name              = "${var.database_name}"
  username = "${var.database_user}"
  password = "${var.database_password}"

  #   Because we're assuming a VPC, we use this option, but only one SG id
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  #   // We're creating a subnet group in the module and passing in the name
  db_subnet_group_name = "${aws_db_subnet_group.main_db_subnet_group.name}"

  # parameter_group_name = "${var.db_parameter_group}"

  #   // We want the multi-az setting to be toggleable, but off by default
  multi_az     = "${var.rds_is_multi_az}"
  storage_type = "${var.rds_storage_type}"
}

resource "aws_db_subnet_group" "main_db_subnet_group" {
  name        = "${var.rds_instance_name}-subnetgrp"
  description = "RDS subnet group"
  subnet_ids  = ["${aws_subnet.one.id}", "${aws_subnet.two.id}"]
}

#todo set some sensible values and assign


# find out which are available with cli: aws rds describe-db-parameters --db-parameter-group-name test-sqlserver-se-12-0 --query 'Parameters[*].ParameterName'


# resource "aws_db_parameter_group" "allow_triggers" {


#    name = "arcgis-${var.env_name}-allow-triggers"


#    family = "sqlserver-se-12.0"


#    description = "Parameter Group for Arcgis ${var.env_tag} to allow triggers"


#    parameter {


#      name = "log_bin_trust_function_creators"


#      value = "1"


#    }


#    tags {


#     Env = "${var.env_tag}"


#    }


# }

