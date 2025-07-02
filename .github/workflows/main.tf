provider "aws" {
 region = us-east-1
}
# create ec2 instance
resource "aws_instance" "ec2_instance" {
      ami = "ami-07b7f66b629de9364"
      instance_type = "t2.micro"
      key_name = aws_key_pair.my_key.key_name
}
resource "aws_key_pair" "my_key" {
      key_name = "test-key"
      public_key = tls_private_key.my_key.public_key_openssh

}
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_security_group" "instance_sg" {

  ingress {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
      }
      ingress {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
      }
      ingress {
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
      }
      egress {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
      }
}
  

