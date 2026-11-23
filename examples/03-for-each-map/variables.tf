variable "workloads" {
  type = map(string)
  default = {
    "rg-analytics-dev" = "eastus"
    "rg-payments-dev"  = "centralus"
  }
}
