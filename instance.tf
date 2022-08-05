resource "aws_instance" "web-server" {

  ami             = "ami-065deacbcaac64cf2"
  instance_type   = "t2.micro"
  count           = 2
  security_groups = ["${aws_security_group.web-server.name}"]
  user_data       = <<-EOF

   #!bin/base_path
   sudo su
   apt-add-repository ppa:nginx/stable
   apt install nginx
   systemctl enable nginx
   echo "<html><h1> “Hello World" from $(hostname -f) ...</p> </h1"
   EOF

  tags = {
    NAME = "instance-${count.index}"
  }
}
