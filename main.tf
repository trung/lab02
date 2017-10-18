provider "aws" {
  region = "us-east-1"
}

variable "my_var" {
  default = "default value"
}

resource "aws_security_group" "allow_all" {
  vpc_id      = "vpc-cda264b5"
  name_prefix = "tfe-lab02-testing-sg"
  description = "Testing TFEv2"

  tags {
    Name = "foo-${uuid()}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_availability_zones" "all" {}

output "myvar" {
  value = "${var.my_var}"
}

output "azs" {
  value = "${data.aws_availability_zones.all.names}"
}
