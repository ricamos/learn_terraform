variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
  type        = list(string)
  default     = ["srv1", "srv2"]
}

variable "location" {
  description = "The location/region where the core network will be created."
  default     = "sa-east-1"
}

variable "instance_count" {
  description = "number of instances"
  default     = 1
}

variable "ami_id" {
  description = "Code of instances System"
  default     = "ami-0c2485d67d416fc4f"
}

variable "instance_type" {
  description = "Code of instances type"
  default     = "t2.micro"
}

variable "ssh_key_name" {
  description = "AWS EC2 ssh key name"
  default     = "acesso"
}

variable "ssh_user_name" {
  description = "SSH user"
  default     = "ec2-user"
}

variable "ssh_key_path" {
  description = "Local ssh key"
  default     = "~/Downloads/acesso.pem"
}