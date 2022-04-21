variable "vms" {
  #type = map(string)
  default = {
    "srv01" = {
      "ami_id" = "ami-0c2485d67d416fc4f"
      "instance_type" = "t2.micro"
      "key_name" = "acesso"
      "instance_count" = 1
    },
    "srv02" = {
      "ami_id" = "ami-0c2485d67d416fc4f"
      "instance_type" = "t2.micro"
      "key_name" = "acesso"
      "instance_count" = 2
    },      
  }
}