variable "location" {
  description = "The location/region where the core network will be created."
  default     = "sa-east-1"
}

variable "vms" {
  #type = map(string)
  default = {
    "srv01" = {
      "ami_id"         = "ami-0c2485d67d416fc4f"
      "instance_type"  = "t2.micro"
      "key_name"       = "acesso"
      "instance_count" = 1
      "ssh_user_name"  = "ec2-user"
      "ssh_key_path"   = "~/Downloads/acesso.pem"
    },
    "srv02" = {
      "ami_id"         = "ami-0c2485d67d416fc4f"
      "instance_type"  = "t2.micro"
      "key_name"       = "acesso"
      "instance_count" = 1
      "ssh_user_name"  = "ec2-user"
      "ssh_key_path"   = "~/Downloads/acesso.pem"
    },
  }
}