resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/24"
  tags = {
    "Name" = "web-1-vpc"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.0.0/26"
  availability_zone = "us-west-1a"
  tags = {
    "Name" = "web-1-public"
  }
}
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "web-1-route-table"
  }
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.this-rt.id
}
resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "web-1-gateway"
  }
}
resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.this-rt.id
  gateway_id             = aws_internet_gateway.this-igw.id
}
resource "aws_network_interface" "this-nic" {
  subnet_id       = aws_subnet.public.id
  private_ips     = [var.private_ip_address]
  security_groups = [aws_security_group.web-pub-sg.id]
  tags = {
    "Name" = "web-1-nic"
  }
}
resource "aws_eip" "ip-one" {
  vpc                       = true
  network_interface         = aws_network_interface.this-nic.id
  tags = {
    "Name" = "web-1-ip"
  }
}