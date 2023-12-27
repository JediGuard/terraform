terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.0.0"
    }
  }
  required_version = "1.6.6"
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "My_VPC"
  }
}

resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "My_IGW"
  }
}

resource "aws_subnet" "my_public_subnet" {
  count = var.subnet_count.public
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_bloks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "my_public_subnet_${count.index}"
  }
}

resource "aws_subnet" "my_private_subnet" {
  count = var.subnet_count.private
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr_bloks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "my_private_subnet_${count.index}"
  }
}

resource "aws_route_table" "my_public_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_ig.id
    }
}

resource "aws_route_table_association" "public" {
  count = var.subnet_count.public
  route_table_id = aws_route_table.my_public_rt.id
  subnet_id = aws_subnet.my_public_subnet[count.index].id
}

resource "aws_route_table" "my_private_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_ig.id
    }
}

resource "aws_route_table_association" "private" {
  count = var.subnet_count.public
  route_table_id = aws_route_table.my_private_rt.id
  subnet_id = aws_subnet.my_private_subnet[count.index].id
}

resource "aws_security_group" "my_web_sg" {
  name = "my_web_app_sg"
  description = "Security group for my web severs"
  vpc_id = aws_vpc.my_vpc.id
  
  ingress {
    description = "Allow all HTTP traffic"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "Allow all SSH traffic"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["10.40.7.120/32"]
  }
  
  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "My_web_sg"
  }
}

resource "aws_security_group" "my_db_sg" {
  name = "my_db_sg"
  description = "Security group for database"
  vpc_id = aws_vpc.my_vpc.id
  
  ingress {
    description = "Allow MYSQL traffic from only the web sq"
    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    #sesecurity_groups = [aws_security_group.my_web_sg.id]
  }
  tags = {
    "Name" = "My_db_sg"
  }
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name = "my_db_subnet_group"
  description = " DB subnet group"
  subnet_ids = [ for subnet in aws_subnet.my_private_subnet : subnet.id ]
}

resource "aws_db_instance" "my_database" {
  allocated_storage = var.settings.database.allocated_storage
  engine = var.settings.database.engine
  engine_version = var.settings.database.engine_version
  instance_class = var.settings.database.instance_class
  db_name = var.settings.database.db_name
  username = var.db_username
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.id
  vpc_security_group_ids = [ aws_security_group.my_db_sg.id ]
  skip_final_snapshot = var.settings.database.skip_final_snapshot
}

resource "aws_key_pair" "my_kp" {
  key_name = "My_kp"
  public_key = file("tutorial_kp.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = "true"
  
  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" ]
  }

  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }

  owners = [ "099720109477" ]
}

resource "aws_instance" "my_web" {
  count = var.settings.web_app.count
  ami = data.aws_ami.ubuntu.id
  instance_type = var.settings.web_app.instance_type
  subnet_id = aws_subnet.my_public_subnet[count.index].id
  key_name = aws_key_pair.my_kp.key_name
#   user_data              = file("userdata.tpl")
  vpc_security_group_ids = [ aws_security_group.my_web_sg.id ]

  tags = {
    Name = "my_web_${count.index}"
  }
}

resource "aws_eip" "my_web_eip" {
  count = var.settings.web_app.count
  instance = aws_instance.my_web[count.index].id
  vpc = true

  tags = {
    Name = "my_web_eip_${count.index}"
  }
}