# Demonstration of for_each over Map
# each.key   = Resource Group Name (e.g. "rg-loops-eastus")
# each.value = Azure Location (e.g. "eastus")
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups_map
  name     = each.key
  location = each.value
}

# Demonstration of for_each over Set of strings
# each.key and each.value are both the string value
resource "azurerm_storage_account" "sa" {
  for_each                 = var.storage_accounts_set
  name                     = each.key
  resource_group_name      = azurerm_resource_group.rg["rg-loops-eastus"].name
  location                 = azurerm_resource_group.rg["rg-loops-eastus"].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
