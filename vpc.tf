resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags = {
    Name = "${var.IGW_name}"
  }
}

# Subnets: public
resource "aws_subnet" "public" {
  count             = "${length(var.subnets_cidr)}"
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${element(var.subnets_cidr,count.index)}"
  availability_zone = "${element(var.azs,count.index)}"

  tags = {
    Name = "Subnet-${count.index+1}"
  }
}

# resource "aws_subnet" "subnet1-public" {
#   vpc_id            = "${aws_vpc.default.id}"
#   cidr_block        = "${var.public_subnet1_cidr}"
#   availability_zone = "ap-south-1a"

#   tags = {
#     Name = "${var.public_subnet1_name}"
#   }
# }

# resource "aws_subnet" "subnet2-public" {
#   vpc_id            = "${aws_vpc.default.id}"
#   cidr_block        = "${var.public_subnet2_cidr}"
#   availability_zone = "ap-south-1b"

#   tags = {
#     Name = "${var.public_subnet2_name}"
#   }
# }

# resource "aws_subnet" "subnet3-public" {
#   vpc_id            = "${aws_vpc.default.id}"
#   cidr_block        = "${var.public_subnet3_cidr}"
#   availability_zone = "ap-south-1c"

#   tags = {
#     Name = "${var.public_subnet3_name}"
#   }

# }


resource "aws_route_table" "terraform-public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags = {
    Name = "${var.Main_Routing_Table}"
  }
}

resource "aws_route_table_association" "terraform-public" {
  count          = "${length(var.subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.terraform-public.id}"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
