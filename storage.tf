resource "azurerm_storage_account" "sa" {
  name                     = "tfdemosa78f993"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.tags

}
resource "azurerm_storage_container" "main" {
  name                  = "xascode"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
