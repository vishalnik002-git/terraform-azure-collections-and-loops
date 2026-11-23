# 1. Map for for_each resource groups
variable "resource_groups_map" {
  type        = map(string)
  description = "A map where key is Resource Group name and value is Azure location."
  default = {
    "rg-loops-eastus"   = "eastus"
    "rg-loops-westus"   = "westus"
    "rg-loops-centralus" = "centralus"
  }
}

# 2. Set of storage account names
variable "storage_accounts_set" {
  type        = set(string)
  description = "A set of unique storage account names."
  default     = ["stloopseast01", "stloopswest01"]
}

# 3. List of strings demonstrating toset() conversion
variable "storage_types_list" {
  type        = list(string)
  description = "A list of strings that must be converted via toset() when used in for_each."
  default     = ["hot", "cool", "archive"]
}
