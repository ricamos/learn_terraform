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
  region  = var.location
}

resource "aws_instance" "app_server" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.ssh_key_name

  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "srv${count.index}"
  }

  connection {
    type        = "ssh"
    user        = var.ssh_user_name
    private_key = file(pathexpand(var.ssh_key_path))
    host        = self.public_ip
  }

  provisioner "local-exec" { 
    command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user_name} -i '${element(aws_instance.app_server.*.public_ip, count.index)},' --private-key ${var.ssh_key_path} play.yaml" 
  }
}

  