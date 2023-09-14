

resource "aws_instance" "ec2_instances" {
  for_each = var.ec2_instances

  ami                    = var.ami           
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  key_name               = each.value.key_name
  user_data              = each.value.user_data
  associate_public_ip_address = each.value.associate_public_ip_address

  tags = {
    Name = each.value.name
  }
}

# provider "tls" {}

# locals {
#   ec2_with_key_pairs = {
#     for ec2 in var.ec2_instances :
#     ec2.create_key_pair => ec2 if ec2.create_key_pair == true
#   }
# }

# resource "tls_private_key" "ec2_key_pairs" {
#   for_each = {
#     for key, ec2 in local.ec2_with_key_pairs :
#     key => ec2
#   }

#   algorithm = "RSA"
# }

# resource "aws_key_pair" "ec2_key_pairs" {
#   for_each = local.ec2_with_key_pairs

#   key_name   = each.value.key_pair_name
#   public_key = tls_private_key.ec2_key_pairs[each.key].public_key_openssh
# }

# provider "tls" {}

# resource "tls_private_key" "ec2_key_pairs" {
#   for_each = { for idx, ec2 in var.ec2_instances : idx => ec2 if ec2.create_key_pair }

#   algorithm = "RSA"
# }

# # data "tls_public_key" "ec2_key_pairs" {
# #   for_each = tls_private_key.ec2_key_pairs

# #   algorithm   = "RSA"
# #   private_key = each.value.private_key_pem
# # }

# resource "aws_key_pair" "ec2_key_pairs" {
#   for_each = tls_private_key.ec2_key_pairs

#   key_name   = each.key
#   public_key = tls_private_key.ec2_key_pairs[each.key].public_key_openssh
# }
