resource "azurerm_resource_group" "shared_rg" {
  name     = "rg-shared-storage"
  location = "eastus"
}

resource "azurerm_storage_account" "multi" {
  for_each                 = var.storage_accounts
  name                     = each.key
  resource_group_name      = azurerm_resource_group.shared_rg.name
  location                 = each.value
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
