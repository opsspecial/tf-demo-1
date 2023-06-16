
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_cidr_block
  dns_servers         = var.dns_servers


  tags = var.tags
}


resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = each.value.address_prefix

}

resource "azurerm_network_security_group" "main" {
  for_each            = var.subnets
  name                = "${each.value.name}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

}

resource "azurerm_subnet_network_security_group_association" "main" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.main[each.key].id
}

resource "azurerm_network_security_rule" "example" {
  for_each                    = var.subnets
  name                        = "${each.value.name}-nsg-rule"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main[each.key].name
  priority                    = each.value.security_rules.rule1.priority
  direction                   = each.value.security_rules.rule1.direction
  access                      = each.value.security_rules.rule1.access
  protocol                    = each.value.security_rules.rule1.protocol
  source_port_range           = each.value.security_rules.rule1.source_port_range
  destination_port_range      = each.value.security_rules.rule1.destination_port_range
  source_address_prefix       = each.value.security_rules.rule1.source_address_prefix
  destination_address_prefix  = each.value.security_rules.rule1.destination_address_prefix
}


