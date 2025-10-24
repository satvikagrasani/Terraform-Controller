variable "resource_group_name" {
  type    = string
  default = "terraform-rg"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vnet_name" {
  type    = string
  default = "terraform-vnet"
}

variable "subnet_names" {
  type    = list(string)
  default = ["subnet-1", "subnet-2"]
}

variable "vm_names" {
  type    = list(string)
  default = ["Azure-App-VM", "Azure-Tools-VM"]
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
