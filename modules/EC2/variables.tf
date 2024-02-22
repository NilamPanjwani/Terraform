variable "instance_type" {
  description = "value for instance_type"
}

variable "env_prefix" {
  description = "environment - test, dev, stag, prod"
}

variable "public_key_location" {
  description = "location of public key"
}

variable "subnet_id" {
  description = "subnet where EC2 will be launched"
}
