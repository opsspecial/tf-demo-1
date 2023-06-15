rg_name         = "demo-rg"
location        = "southindia"
vnet_name       = "demo-vnet"
vnet_cidr_block = ["10.10.0.0/16"]
dns_servers     = ["10.10.0.1", "10.10.0.2"]
tags = {
  "environment" = "testing"
  "project"     = "X-as-Code"
}
