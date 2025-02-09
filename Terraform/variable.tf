variable "vpcid" {
  description = "The CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "region" {
  description = "AWS region to deploy the resources"
  default     = "us-east-1"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  default     = ["192.168.1.0/16", "192.168.2.0/16", "192.168.3.0/16"]
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  default     = ["192.168.4.0/16", "192.168.5.0/16", "192.168.6.0/16"]
}