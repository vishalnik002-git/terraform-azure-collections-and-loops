resource "azurerm_resource_group" "workload_rgs" {
  for_each = var.workloads
  name     = each.key
  location = each.value
}
