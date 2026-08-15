resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "this" {
  count  = var.igw_required ? 1 : 0
  vpc_id = aws_vpc.this.id
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each   = { for s in var.public_subnets : s.name => s }
  vpc_id     = aws_vpc.this.id
  cidr_block = each.value.cidr
  availability_zone = each.value.availability_zone
  tags = {
    Name = each.value.name
  }
}

# Public Route Tables
resource "aws_route_table" "public" {
  for_each = { for s in var.public_subnets : s.name => s if s.route_table_required }
  vpc_id   = aws_vpc.this.id
  tags = {
    Name = each.value.route_table_name
  }
}

# Public Routes
resource "aws_route" "public" {
  for_each = { for s in var.public_subnets : s.name => s if s.public_route_required }
  route_table_id         = aws_route_table.public[each.value.name].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

# Public Route Table Associations
resource "aws_route_table_association" "public" {
  for_each      = { for s in var.public_subnets : s.name => s if s.route_table_required }
  subnet_id     = aws_subnet.public[each.value.name].id
  route_table_id = aws_route_table.public[each.value.name].id
}

# NAT Gateways
resource "aws_eip" "nat" {
  for_each = { for n in var.nat_gateways : n.name => n if n.eip_required }
#   vpc = true
}

resource "aws_nat_gateway" "this" {
  for_each     = { for n in var.nat_gateways : n.name => n }
  subnet_id    = each.value.subnet_id
  allocation_id = each.value.eip_required ? aws_eip.nat[each.value.name].id : null
  tags = {
    Name = each.value.name
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each   = { for s in var.private_subnets : s.name => s }
  vpc_id     = aws_vpc.this.id
  cidr_block = each.value.cidr
  availability_zone = each.value.availability_zone
  tags = {
    Name = each.value.name
  }
}

# Private Route Tables
resource "aws_route_table" "private" {
  for_each = { for s in var.private_subnets : s.name => s if s.private_route_required }
  vpc_id   = aws_vpc.this.id
  tags = {
    Name = "${each.value.name}-rt"
  }
}

# Private Routes
resource "aws_route" "private" {
  for_each = { for s in var.private_subnets : s.name => s if s.private_route_required }
  route_table_id         = aws_route_table.private[each.value.name].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.value.nat_gateway_name].id
}

# Private Route Table Associations
resource "aws_route_table_association" "private" {
  for_each      = { for s in var.private_subnets : s.name => s if s.private_route_required }
  subnet_id     = aws_subnet.private[each.value.name].id
  route_table_id = aws_route_table.private[each.value.name].id
}
