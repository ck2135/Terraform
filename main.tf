#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
  #access_key = "${var.aws_access_key}"
  #secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

# resource "aws_vpc" "default" {
#   cidr_block           = "${var.vpc_cidr}"
#   enable_dns_hostnames = true
#   tags = {
#     Name = "${var.vpc_name}"
#   }
# }

# resource "aws_internet_gateway" "default" {
#   vpc_id = "${aws_vpc.default.id}"
#   tags = {
#     Name = "${var.IGW_name}"
#   }
# }

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


# resource "aws_route_table" "terraform-public" {
#   vpc_id = "${aws_vpc.default.id}"

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = "${aws_internet_gateway.default.id}"
#   }

#   tags = {
#     Name = "${var.Main_Routing_Table}"
#   }
# }

# resource "aws_route_table_association" "terraform-public" {
#   subnet_id      = "${aws_subnet.subnet1-public.id}"
#   route_table_id = "${aws_route_table.terraform-public.id}"
# }

# resource "aws_security_group" "allow_all" {
#   name        = "allow_all"
#   description = "Allow all inbound traffic"
#   vpc_id      = "${aws_vpc.default.id}"

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

#terraform {
#  backend "s3" {
#    bucket = "terraform-may20"
#    key    = "test.tfstate"
#    region = "ap-south-1"
#  }
#}

# output "My_VPC_Name" {
#     value = "${aws_vpc.default.tags.Name}"
# }

# output "My_VPC_ID" {
#     value = "${aws_vpc.default.id}"
# }

# output "My_TestServer_Name" {
#     value = "${aws_instance.web-1.tags.Name}"
# }
# data "aws_ami" "my_ami" {
#      most_recent      = true
#      #name_regex       = "^mavrick"
#      owners           = ["721834156908"]
# }


##output "ami_id" {
#  value = "${data.aws_ami.my_ami.id}"
#}
#!/bin/bash
# echo "Listing the files in the repo."
# ls -al
# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo "Running Packer Now...!!"
# packer build -var=aws_access_key=AAAAAAAAAAAAAAAAAA -var=aws_secret_key=BBBBBBBBBBBBB packer.json
#packer validate --var-file creds.json packer.json
#packer build --var-file creds.json packer.json
#packer.exe build --var-file creds.json -var=aws_access_key=AAAAAAAAAAAAAAAAAA -var=aws_secret_key=BBBBBBBBBBBBB packer.json
# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo "Running Terraform Now...!!"
# terraform init
# terraform apply --var-file terraform.tfvars -var="aws_access_key=AAAAAAAAAAAAAAAAAA" -var="aws_secret_key=BBBBBBBBBBBBB" --auto-approve
#https://discuss.devopscube.com/t/how-to-get-the-ami-id-after-a-packer-build/36
