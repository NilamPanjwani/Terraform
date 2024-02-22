variable "vpc_cidr_block" {
  description = "value for cidr block for VPC"
}

variable "env_prefix" {
  description = "environment - test, dev, stag, prod"
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

variable "AZ_subnet_private" {
  description = "value for AZ for the private subnet"
}