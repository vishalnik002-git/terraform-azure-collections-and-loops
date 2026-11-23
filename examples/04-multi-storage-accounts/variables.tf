variable "storage_accounts" {
  type = map(string)
  default = {
    "stmultidata01" = "eastus"
    "stmultilogs02" = "eastus"
  }
}
