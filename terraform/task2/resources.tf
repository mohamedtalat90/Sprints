resource "aws_vpc" "sprint-vpc" {
  cidr_block = var.vpc_cidr
    tags = {
        Name = "sprint-vpc"
        }
}

resource "aws_internet_gateway" "sprint-igw" {
  vpc_id = aws_vpc.sprint-vpc.id
     tags = {
        Name = "sprint-igw"
        }
}

resource "aws_eip" "sprint-nat-eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.sprint-igw]
}

resource "aws_nat_gateway" "sprint-nat" {
  allocation_id = aws_eip.sprint-nat-eip.id
  subnet_id     = aws_subnet.sprint-subnets[0].id
  depends_on    = [aws_internet_gateway.sprint-igw]
  tags = { Name = "sprint-nat" }
}

resource "aws_subnet" "sprint-subnets" {
 count             = length(var.subnet_cidrs)
 cidr_block        = var.subnet_cidrs[count.index]
 vpc_id          =   aws_vpc.sprint-vpc.id
 tags              = merge(var.subnet_tags, { "Name" = "Subnet ${count.index + 1}" })

}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.sprint-vpc.id
  tags = { Name = "private-rt" }
}
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.sprint-nat.id
}
resource "aws_route_table" "publit-rt" {
  vpc_id = aws_vpc.sprint-vpc.id

  route {
    gateway_id = aws_internet_gateway.sprint-igw.id
    cidr_block = var.route_cidr_block
  }
    tags = { Name = "publit-rt" }

}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.sprint-subnets[0].id
  route_table_id = aws_route_table.publit-rt.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.sprint-subnets[1].id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_security_group" "public-securit-group" {
  name        = "public-securit-group"
  description = "Public Security Group"
  vpc_id      = aws_vpc.sprint-vpc.id

  ingress {
    from_port   = var.public-securit-group_ingress_ports[0]
    to_port     = var.public-securit-group_ingress_ports[0]
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  ingress {
    from_port   = var.public-securit-group_ingress_ports[1]
    to_port     = var.public-securit-group_ingress_ports[1]
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  ingress {
    from_port   = var.public-securit-group_ingress_ports[2]
    to_port     = var.public-securit-group_ingress_ports[2]
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = { Name = "public-securit-group" }
}

resource "aws_security_group" "private-security-group" {
  name        = "private-security-group"
  description = "Private Security Group"
  vpc_id      = aws_vpc.sprint-vpc.id

  ingress {
    from_port       = var.private-security-group_ingress_ports[0]
    to_port         = var.private-security-group_ingress_ports[0]
    cidr_blocks = [var.subnet_cidrs[0]]
    protocol        = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = { Name = "private-security-group" }
}



resource "aws_instance" "public_instance" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sprint-subnets[0].id
  vpc_security_group_ids      = [aws_security_group.public-securit-group.id]
  associate_public_ip_address = true
  user_data                   = file("apache.sh")
  tags = { Name = "public_instance" }
}

resource "aws_instance" "private_instance" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sprint-subnets[1].id
  vpc_security_group_ids      = [aws_security_group.private-security-group.id]
  associate_public_ip_address = false
  user_data                   = file("apache.sh")
  tags = { Name = "private_instance" }
}
