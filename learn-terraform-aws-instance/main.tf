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
  region  = "sa-east-1"
}
  
resource "aws_instance" "app_server" {
  count = 4 
  ami           = "ami-0c2485d67d416fc4f"
  instance_type = "t2.micro"
  key_name   = "ricardo"

  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "srv${count.index}"  
  }
}

		