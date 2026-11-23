output "created_rg_names" {
  value = azurerm_resource_group.counted[*].name
}
