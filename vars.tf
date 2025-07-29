variable "resource_group_name" {
  type    = string
  default = "demotf"

}
variable "subscription_id" {
  type    = string
}
variable "location" {
  type    = string
  default = "eastus"
}

variable "vm_name" {
  type    = string
  default = "demo-vm"
  
}

variable "virtual_network_name" {
  type    = string
  default = "demo-vnet"
}

variable "subnet_name" {
  type    = string
  default = "demo-subnet"
}

variable "nic-name" {
  type    = string
  default = "demo-nic"
  
}