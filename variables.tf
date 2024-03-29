variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "amis" {
  description = "AMIs by region"
  default = {
    ap-south-1 = "ami-97785bed" # ubuntu 14.04 LTS
    ap-south-2 = "ami-f63b1193" # ubuntu 14.04 LTS
    ap-south-1 = "ami-824c4ee2" # ubuntu 14.04 LTS
    ap-south-2 = "ami-f2d3638a" # ubuntu 14.04 LTS
  }
}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "IGW_name" {}
variable "key_name" {}
#variable "public_subnet1_cidr" {}
#variable "public_subnet2_cidr" {}
#variable "public_subnet3_cidr" {}
#variable "private_subnet_cidr" {}
variable "public_subnet1_name" {}
variable "public_subnet2_name" {}
variable "public_subnet3_name" {}
variable "private_subnet_name" {}
variable "Main_Routing_Table" {}
variable "subnets_cidr" {
  type = list
  default = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = list
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}
variable "environment" { default = "dev" }
variable "instance_type" {
  #type = "map"
  default = {
    dev  = "t2.nano"
    test = "t2.micro"
    prod = "t2.medium"
  }
}
variable "number_instances" {}
variable "ec2_name" {}
