# LIST(STRING)

resource "azurerm_resource_group" "list_rg" {

  for_each = toset(var.rg_list)

  name     = each.value
  location = "East US"
}

# SET(STRING)

resource "azurerm_resource_group" "set_rg" {

  for_each = var.rg_set

  name     = each.value
  location = "West US"
}

# MAP(STRING)

resource "azurerm_resource_group" "map_rg" {

  for_each = var.rg_map

  name     = each.key
  location = each.value
}