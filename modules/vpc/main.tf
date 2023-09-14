resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags      = { Name = var.vpc_name }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# variable "public_subnet_cidr_blocks" {
#   description = "A map of public subnet CIDR blocks with corresponding AZs."
#   type        = map(string)
#   default = {
#     "us-east-1a" = "10.0.1.0/24"
#     "us-east-1b" = "10.0.2.0/24"
#   }
# }

# variable "private_subnet_cidr_blocks" {
#   description = "A map of private subnet CIDR blocks with corresponding AZs."
#   type        = map(string)
#   default = {
#     "us-east-1a" = "10.0.3.0/24"
#     "us-east-1b" = "10.0.4.0/24"
#   }
# }

resource "aws_subnet" "public" {
  for_each = var.public_subnet_cidr_blocks

  availability_zone = each.key
  cidr_block        = each.value
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  for_each = var.private_subnet_cidr_blocks

  availability_zone = each.key
  cidr_block        = each.value
  vpc_id            = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  for_each = aws_subnet.public
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.main.id
}

resource "aws_nat_gateway" "nat" {
  for_each     = aws_subnet.private
  subnet_id    = aws_subnet.private[each.key].id
  allocation_id = aws_eip.eipnat[each.key].id
  depends_on   = [aws_internet_gateway.igw]
}

resource "aws_eip" "eipnat" {
  for_each = aws_subnet.private
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

# variable "public_subnet_cidr_blocks" {
#   description = "A map of public subnet CIDR blocks with corresponding AZs."
#   type        = map(string)
#   default = {
#     "us-east-1a" = "10.0.1.0/24"
#     "us-east-1b" = "10.0.2.0/24"
#   }
# }

# variable "private_subnet_cidr_blocks" {
#   description = "A map of private subnet CIDR blocks with corresponding AZs."
#   type        = map(string)
#   default = {
#     "us-east-1a" = "10.0.3.0/24"
#     "us-east-1b" = "10.0.4.0/24"
#   }
# }


# resource "aws_subnet" "subnet" {
#   for_each = var.subnets

#   vpc_id            = aws_vpc.main.id
#   cidr_block        = each.value["cidr_block"]
#   availability_zone = each.value["availability_zone"]
#   tags              = { Name = each.key }
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "Public Route Table"
#   }


# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "Private Route Table"
#   }
# }

# resource "aws_route_table" "database" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "Database Route Table"
#   }
# }

# resource "aws_route_table_association" "public" {
#   for_each = aws_subnet.subnet

#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table_association" "private" {
#   for_each = aws_subnet.subnet

#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_route_table_association" "database" {
#   for_each = aws_subnet.subnet

#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.database.id
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "Main Internet Gateway"
#   }
# }

# resource "aws_nat_gateway" "nat" {
#   for_each = toset([for subnet in var.subnets : subnet["type"] == "private"])

#   allocation_id = aws_eip.nat[each.key].id
#   subnet_id     = aws_subnet.subnet[each.key].id
# }

# resource "aws_eip" "nat" {
#   domain = "vpc"
#  for_each = toset([for subnet in var.subnets : subnet["type"] == "private"])
#   depends_on = [aws_internet_gateway.igw]
# }



