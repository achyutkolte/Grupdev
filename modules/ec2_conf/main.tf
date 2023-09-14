provider "aws" {
  region = "us-east-1"           
}

module "ec2_instances" {
  source = "../modules/EC2"

  ec2_instances = {
    public_instance = {
      name              = "PublicInstance"
      instance_type     = "t2.micro"
      subnet_id         = "subnet-0dff05883fc5c82c0" # Public subnet ID
      key_name          = "public_key"
      user_data         = "#!/bin/bash\necho 'Hello from public instance'"
      associate_public_ip_address = true
    }

    private_instance = {
      name              = "PrivateInstance"
      instance_type     = "t2.micro"
      subnet_id         = "subnet-0239f7c52a9afaca1" # Private subnet ID
      key_name          = "private_key"
      user_data         = "#!/bin/bash\necho 'Hello from private instance'"
      associate_public_ip_address = false
    }
  }
}
