# modules/vpc/main.tf
resource "aws_vpc" "this" {
  cidr_block = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.name}-private-${count.index}"
  }
}

# Output example
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "vpc_id" {
  value = aws_vpc.this.id
}
