variable "rg_count" {
  type        = number
  description = "Number of Resource Groups to provision."
  default     = 2
}

variable "location" {
  type    = string
  default = "eastus"
}
