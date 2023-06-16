resource "azurerm_public_ip" "web" {
  name                = "web-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  tags                = var.tags

}

resource "azurerm_network_interface" "web" {
  name                = "main-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {

    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets["subnet1"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id
  }

  depends_on = [azurerm_virtual_network.main, azurerm_public_ip.web]
}


resource "azurerm_virtual_machine" "main" {
  name                  = var.webvm.name
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.web.id]
  vm_size               = var.webvm.size

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name = "web"
    admin_username = "webadmin"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {

      key_data = file("/home/ikiran/.ssh/id_rsa.pub")
      path= "/home/webadmin/.ssh/authorized_keys"
    }
  }
 tags = var.tags

}