variable "rds_instance_name" {
  default = "test"
}

variable "rds_is_multi_az" {
  default = "false"
}

variable "rds_storage_type" {
  default = "standard"
}

variable "rds_allocated_storage" {
  description = "The allocated storage in GBs"

  # You just give it the number, e.g. 20 - 1024
  default = 20
}

variable "rds_engine_type" {
  default = "sqlserver-ex"

  # // Valid types are

  # // - mysql

  # // - postgres

  # // - oracle-*

  # // - sqlserver-*

  # // See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html

  # // --engine
}

variable "rds_engine_version" {
  # // For valid engine versions, see:
  # // See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  # // --engine-version
  default = "13.00.2164.0.v1"
}

variable "rds_instance_class" {
  #--db-instance-class 
  default = "db.t2.micro"
}

variable "database_name" {
  description = "The name of the database to create"
  default     = "TestDb"
}

variable "database_user" {
  default = "superbasti"
}

variable "database_password" {
  default = "V8eMSqHaZ6xp"
}

#add security group and subnet to main and dynamically create it
# variable "rds_security_group_id" {}

# // RDS Subnet Group Variables
# variable "subnet_az1" {}
# variable "subnet_az2" {}

variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_az1" {
  default = "eu-central-1a"
}

variable "aws_az2" {
  default = "eu-central-1b"
}
