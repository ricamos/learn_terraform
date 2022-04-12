variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
  type        = list(string)
  default     = ["srv1","srv2"]
}

variable "location" {
  description = "The location/region where the core network will be created."
  default     = "sa-east-1"
}