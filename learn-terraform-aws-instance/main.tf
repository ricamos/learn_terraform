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

locals {
  list_instance_count = length(flatten([for i in var.vms : range(i["instance_count"])]))
  list_ami_id         = [for i in var.vms : i["ami_id"]]
  list_instance_type  = [for i in var.vms : i["instance_type"]]
  list_key_name       = [for i in var.vms : i["key_name"]]
  list_name           = tolist(keys(var.vms))
  list_ssh_user_name  = [for i in var.vms : i["ssh_user_name"]]
  list_ssh_key_path   = [for i in var.vms : i["ssh_key_path"]]
}

resource "aws_instance" "app_server" {
  count         = local.list_instance_count
  ami           = element(local.list_ami_id, count.index + 1)
  instance_type = element(local.list_instance_type, count.index + 1)
  key_name      = element(local.list_key_name, count.index + 1)

  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = element(local.list_name, count.index + 1)
  }
}

resource "null_resource" "ProvisionRemoteHostsIpToAnsibleHosts" {
  count = local.list_instance_count
  connection {
    type        = "ssh"
    user        = element(local.list_ssh_user_name, count.index + 1)
    private_key = file(pathexpand(element(local.list_ssh_key_path, count.index + 1)))
    host        = element(aws_instance.app_server.*.public_ip, count.index)
  }

  provisioner "local-exec" {
    command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${element(local.list_ssh_user_name, count.index + 1)} -i '${element(aws_instance.app_server.*.public_ip, count.index)},' --private-key ${element(local.list_ssh_key_path, count.index + 1)} play.yaml"
  }
}  