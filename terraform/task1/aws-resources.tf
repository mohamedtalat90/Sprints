#create amazon VPC
resource "aws_vpc" "sprint-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "terraform"
  }
}
#create amazon Subnet
resource "aws_subnet" "sprint-subnet" {
    vpc_id     = aws_vpc.sprint-vpc.id
    cidr_block= "10.0.0.0/24"
    tags = {
        Name = "terraform"
  }
}
#create amazon Internet gate way
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.sprint-vpc.id
}
#create amazon Routing table
resource "aws_route_table" "sprint-route-table" {
  vpc_id = aws_vpc.sprint-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "PublicRtassociation" {
    subnet_id = aws_subnet.sprint-subnet.id
    route_table_id = aws_route_table.sprint-route-table.id
}

#create amazon Security group
resource "aws_security_group" "sprint_security_group" {
  name        = "ec2 security group"
  description = "access for ports 80 and 22"
  vpc_id      = aws_vpc.sprint-vpc.id

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags   = {
    Name = "sprint-security group"
  }
}

data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
#create amazon EC2
resource "aws_instance" "sprint-terraform-instance" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "terraform-sprints-key"
  security_groups = [aws_security_group.sprint_security_group.id]
  associate_public_ip_address = true
  subnet_id = aws_subnet.sprint-subnet.id
  user_data = file("apache.sh")
  tags = {
    "Name" = "ec2-sprint-terraform1"
  }
}
