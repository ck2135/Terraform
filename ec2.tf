resource "aws_instance" "webservers" {
  count = var.number_instances
  ami = "ami-0c6615d1e95c98aca"
  #ami = "${data.aws_ami.my_ami.id}"
  availability_zone = "${element(var.azs,count.index)}"
  instance_type               = "t2.micro"
  key_name                    = "${var.key_name}"
  #count                       = "${length(var.subnets_cidr)}"
  subnet_id                   = "${element(aws_subnet.public.*.id, count.index)}"
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  
  user_data= <<-EOF
              #!/bin/bash
              yum install httpd -y
              echo "Hello welcome to $(hostname)" > /var/www/html/index.html
              service httpd start
              chkconfig httpd on
  EOF
  tags = {
    Name = "Server-${count.index+1}"
    Env  = "Test"
  }
}