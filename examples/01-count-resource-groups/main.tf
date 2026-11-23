# Demonstration of count with count.index
resource "azurerm_resource_group" "counted" {
  count    = var.rg_count
  name     = "rg-count-demo-${count.index + 1}"
  location = var.location
}
