# configure aws provider

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}
provider "aws" {
    region = var.region
}

module "vpc1" {
  source   = "../../modules/vpc"
  vpc_name = "myvpc"
  vpc_cidr = "10.0.0.0/16"
  subnets  = {
    "public-subnet-1" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      type              = "public"
    },
    "private-subnet-1" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      type              = "private"
    },
    "database-subnet-1" = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1c"
      type              = "database"
    },
  }
}


module "ec2_instances" {
  source = "../../modules/ec2"

  ec2_instances = {
    public_instance = {
      name              = "PublicInstance"
      instance_type     = "t2.micro"
      subnet_id         = module.vpc1.subnet_id                             # "aws_subnet.public.id" # Public subnet ID
      key_name          = "public_key"
      user_data         = "#!/bin/bash\necho 'Hello from public instance'"
      associate_public_ip_address = true
    }

    private_instance = {
      name              = "PrivateInstance"
      instance_type     = "t2.micro"
      subnet_id         = module.vpc1.subnet_id                                            # "aws_subnet.private.id" # Private subnet ID
      key_name          = "private_key"
      user_data         = "#!/bin/bash\necho 'Hello from private instance'"
      associate_public_ip_address = false
    }
  }
}

# #create vpc
# module "vpc" {
#     source = "../modules/vpc"
#  region = var.region
#  project_name = var.project_name
#  vpc_cidr = var.vpc_cidr
#  public_subnet_az1_cidr = var.public_subnet_az1_cidr
#  public_subnet_az2_cidr = var.public_subnet_az2_cidr
#  private_subnet_az1_cidr = var.private_subnet_az1_cidr
#  private_subnet_az2_cidr = var.private_subnet_az2_cidr

# }
