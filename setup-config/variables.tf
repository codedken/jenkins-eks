variable "vpc_cidr" {
  description = "The VPC cidr"
  type        = string
}

variable "vpc_public_subnets" {
  description = "The public subnets within the VPC"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "Name for key pair created on already created on AWS"
  type        = string
}
