variable "roles" {
  type    = set(string)
  default = ["frontend", "backend", "database"]
}
