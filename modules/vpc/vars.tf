variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "Map of subnets with their CIDR blocks and availability zones"
  type        = map(object({
    cidr_block        = string
    availability_zone = string
    type              = string
  }))
}
variable "public_subnet_cidr_blocks" {
  description = "A map of public subnet CIDR blocks with corresponding AZs."
  type        = map(string)
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
}

variable "private_subnet_cidr_blocks" {
  description = "A map of private subnet CIDR blocks with corresponding AZs."
  type        = map(string)
  default = {
    "us-east-1a" = "10.0.3.0/24"
    "us-east-1b" = "10.0.4.0/24"
  }
}
