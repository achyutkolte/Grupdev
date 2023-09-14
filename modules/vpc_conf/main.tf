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
  source   = "../modules/vpc"
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
