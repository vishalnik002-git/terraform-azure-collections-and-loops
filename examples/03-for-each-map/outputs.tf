output "workload_rg_ids" {
  value = { for k, v in azurerm_resource_group.workload_rgs : k => v.id }
}
