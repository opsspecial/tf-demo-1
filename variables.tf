variable "rg_name" {
  type        = string
  description = "Name for your resource Group"
  default     = "tf-rg"

}

variable "location" {
  type        = string
  description = "Azure Region where you want to create resources"
  default     = "southindia"

}


variable "vnet_name" {
  type        = string
  description = "Name of your virtual network"
  default     = "myvnet"

}

variable "vnet_cidr_block" {
  type        = list(string)
  description = "Address range for the VNET"
  default     = ["10.0.0.0/16"]

}

variable "admin_password" {
  type        = string
  description = "Password for Windows Machine"
  sensitive   = true

}

variable "dns_servers" {
  type        = list(any)
  description = "lsit of dns_servers"
  default     = ["10.0.0.1", "10.0.0.2"]
}

variable "tags" {
  type        = map(string)
  description = "Map of tags for your resources"
  default = {
    "environment" = "testing"
    "project"     = "X-as-Code"
  }

}


variable "subnets" {
  type = map(object({
    name           = string
    address_prefix = list(string)
    security_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))

}


variable "webvm" {
  type = object({
    name = string
    size = string
    })
}