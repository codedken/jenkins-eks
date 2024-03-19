variable "vpc_cidr" {
  description = "The VPC cidr"
  type        = string
}

variable "vpc_private_subnets" {
  description = "The private subnets within the VPC where the EKS will be deployed"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "The public subnets within the VPC"
  type        = list(string)
}


variable "cluster_name" {
  description = "The name of the eks cluster"
  type        = string
}
