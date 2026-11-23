output "resource_group_names" {
  description = "List of all created Resource Group names using for expression."
  value       = [for rg in azurerm_resource_group.rg : rg.name]
}

output "storage_account_endpoints" {
  description = "Map of Storage Account names to their primary blob endpoints."
  value = {
    for k, sa in azurerm_storage_account.sa : k => sa.primary_blob_endpoint
  }
}
