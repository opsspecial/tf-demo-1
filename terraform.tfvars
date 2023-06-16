rg_name         = "demo-rg"
location        = "southindia"
vnet_name       = "demo-vnet"
vnet_cidr_block = ["10.10.0.0/16"]
dns_servers     = ["10.10.0.1", "10.10.0.2"]
tags = {
  "environment" = "testing"
  "project"     = "X-as-Code"
}

subnets = {

  subnet1 = {
    name           = "public"
    address_prefix = ["10.10.1.0/24"]
    security_rules = {
      rule1 = {
        name                       = "Rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "87.134.29.45/32"
        destination_address_prefix = "*"
      }

    }
  }
  subnet2 = {
    name           = "web"
    address_prefix = ["10.10.2.0/24"]
    security_rules = {
      rule1 = {
        name                       = "Rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
  subnet3 = {
    name           = "app"
    address_prefix = ["10.10.3.0/24"]
    security_rules = {
      rule1 = {
        name                       = "Rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "10.10.1.0/24"
        destination_address_prefix = "*"
      }
    }
  }
  subnet4 = {
    name           = "db"
    address_prefix = ["10.10.4.0/24"]
    security_rules = {
      rule1 = {
        name                       = "Rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }

}

webvm = {
  name = "web-server"
  size = "Standard_B1s"
}