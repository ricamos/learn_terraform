terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "${var.location}"
}

resource "aws_instance" "app_server" {
  count         = "${var.instance_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.ssh_key_name}"

  tags = {  
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "srv${count.index}"
  }
}

  