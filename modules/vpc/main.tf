locals {
  az_count = var.az_count
}

data "aws_availability_zones" "available" {
  state = "available"
}

# CREATE VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.project_name}-vpc" }
}

# PUBLIC SUBNETS (one per AZ)
resource "aws_subnet" "public" {
  for_each = toset(slice(data.aws_availability_zones.available.names, 0, local.az_count))
  vpc_id   = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, index(slice(data.aws_availability_zones.available.names, 0, local.az_count), each.key))
  availability_zone = each.key
  map_public_ip_on_launch = true
  tags = { Name = "${var.project_name}-public-${each.key}"}
}

# PRIVATE SUBNETS (one per AZ)
resource "aws_subnet" "private" {
  for_each = toset(slice(data.aws_availability_zones.available.names, 0, local.az_count))
  vpc_id   = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, length(slice(data.aws_availability_zones.available.names, 0, local.az_count)) + index(slice(data.aws_availability_zones.available.names, 0, local.az_count), each.key))
  availability_zone = each.key
  map_public_ip_on_launch = false
  tags = { Name = "${var.project_name}-private-${each.key}"}
}

# Internet Gateway and public route table
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project_name}-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.project_name}-public-rt" }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

#############################
# Per-AZ NAT Gateways (one NAT per public subnet)
#############################
resource "aws_eip" "nat_eip" {
  for_each = aws_subnet.public
  tags = { 
    Name = "${var.project_name}-nat-eip-${each.key}" }
}

resource "aws_nat_gateway" "nat" {
  for_each = aws_subnet.public
  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = each.value.id
  depends_on = [aws_internet_gateway.igw]
  tags = { Name = "${var.project_name}-nat-${each.key}" }
}

# Private route table per private subnet mapping to the NAT in the same AZ
resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    # find NAT in the same AZ (assumes public subnet exists in same AZ)
    nat_gateway_id = aws_nat_gateway.nat[each.key].id
  }
  tags = { Name = "${var.project_name}-private-rt-${each.key}" }
}

resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
