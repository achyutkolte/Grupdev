variable "ec2_instances" {
  description = "A map of EC2 instance configurations"
  type        = map(object({
    name              = string
    instance_type     = string
    subnet_id         = string
    key_name          = string
    user_data         = string
    associate_public_ip_address = bool
  }))
}

variable "ami" {
    default = "ami-053b0d53c279acc90"
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instances should be launched."
}
