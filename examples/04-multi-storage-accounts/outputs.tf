output "storage_ids" {
  value = { for k, s in azurerm_storage_account.multi : k => s.id }
}
