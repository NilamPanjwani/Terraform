variable "instance_type" {
  description = "value for instance_type"
}

variable "env_prefix" {
  description = "environment - test, dev, stag, prod"
}

variable "public_key_location" {
  description = "location of public key"
}

variable "vpc_cidr_block" {
  description = "value for cidr block for VPC"
}

variable "subnet_public_cidr_block" {
  description = "value for cidr block public subnet"
}

variable "subnet_private_cidr_block" {
  description = "value for cidr block private subnet"
}

variable "AZ_subnet_public" {
  description = "value for AZ for the public subnet"
}

variable "AZ_subnet_private" {}

variable "allocated_storage" {}

variable "db_name" {}

variable "engine" {}

variable "engine_version" {}

variable "instance_class" {}

variable "username" {}

variable "password" {}

variable "parameter_group_name" {}

variable "skip_final_snapshot" {}

variable "desired_capacity" {}

variable "max_size" {}

variable "min_size" {}

variable "cidr_blocks" {}
