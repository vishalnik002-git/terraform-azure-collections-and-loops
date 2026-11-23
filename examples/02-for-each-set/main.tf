locals {
  service_tags = {
    for role in var.roles : role => "role-${role}-service"
  }
}
