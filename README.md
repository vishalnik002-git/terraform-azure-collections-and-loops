# 🔁 Terraform Loops & Collections: Count vs For_Each

![Terraform Version](https://img.shields.io/badge/Terraform-1.5%2B-blue.svg?logo=terraform)
![Azure Provider](https://img.shields.io/badge/AzureRM-3.100%2B-0078D4.svg?logo=microsoft-azure)
![IaC](https://img.shields.io/badge/IaC-Loops%20%26%20Collections-623CE4.svg)
![Validation](https://img.shields.io/badge/Validation-Pass-success.svg)

> **Repository 04 of 08 in the Terraform + Microsoft Azure Professional Learning Series**

---

## 📌 Navigation
| ⏪ Previous Repository | 📚 Current Repository | ⏩ Next Repository |
| :--- | :---: | :--- |
| [← 03. terraform-azure-variables-and-data-types](https://github.com/vishalnik002-git/terraform-azure-variables-and-data-types) | **04. terraform-azure-collections-and-loops** | [05. terraform-azure-nested-maps-and-dependencies →](https://github.com/vishalnik002-git/terraform-azure-nested-maps-and-dependencies) |

---

## 📖 Project Overview

Creating resources one-by-one by copying and pasting configuration blocks leads to unmanageable code.
This repository explores how to automate the provisioning of multiple homogeneous cloud resources using **Terraform iteration mechanisms**:
- **`count`**: Numeric iteration using zero-indexed arrays (`count.index`).
- **`for_each`**: Key-value iteration using Sets (`toset()`) and Maps (`each.key`, `each.value`).

It explains the trade-offs between `count` and `for_each` and why senior DevOps engineers prioritize `for_each` for state stability.

> ℹ️ **Learning Note**: This repository contains learning configurations and documentation. Automated validation checks verify HCL syntax without provisioning live Azure cloud resources.

---

## 🎯 Learning Objectives

By exploring this repository, you will understand:
1. How `count` provisions multiple resources and how `count.index` dynamically numbers resource names.
2. The **Index Shifting Pitfall** of `count` when removing elements from the middle of a list.
3. How `for_each` operates over Sets and Maps to provide stable, key-addressable resource identifiers.
4. Why `for_each` does **not** accept raw lists, and how `toset()` safely transforms a list into a valid set.
5. How `each.key` and `each.value` work when iterating through maps.
6. How to write Terraform `for` expressions to build dynamic outputs.

---

## ⚖️ Count vs For_Each Comparison

| Feature | `count` | `for_each` |
| :--- | :--- | :--- |
| **Input Type** | Integer (e.g. `count = 3`) | `map` or `set(string)` |
| **Addressing** | Numerical index: `azurerm_resource_group.rg[0]` | Key-based: `azurerm_resource_group.rg["eastus"]` |
| **Deletion Impact** | **Risky**: Removing item 0 shifts all indexes, causing recreation of all subsequent resources! | **Safe**: Deleting a key only destroys that specific resource; other keys remain unaffected. |
| **Best Used For** | Identical toggle instances (`count = var.enabled ? 1 : 0`) | Collections where resources have distinct names or settings. |

---

## 📂 Repository Structure

```
terraform-azure-collections-and-loops/
├── .github/
│   └── workflows/
│       └── validate.yml          # Automated CI validation pipeline
├── examples/
│   ├── 01-count-resource-groups/ # Count demonstration with count.index
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── 02-for-each-set/          # for_each demonstration with Sets
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── 03-for-each-map/          # for_each demonstration with Maps
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── 04-multi-storage-accounts/# Provisioning multiple storage accounts
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── versions.tf
├── .gitignore                    # Prevents committing state and sensitive data
├── main.tf                       # Primary for_each demonstration over Map & Set
├── outputs.tf                    # Dynamic outputs using for expressions
├── providers.tf                  # AzureRM provider configuration
├── terraform.tfvars.example      # Example input parameters
├── variables.tf                  # Parameterized collections
├── versions.tf                   # Version constraint declarations
└── README.md                     # Comprehensive documentation
```

---

## 🧩 Technical Rules & Code Patterns

### 1. Count with Index
```hcl
resource "azurerm_resource_group" "counted" {
  count    = 2
  name     = "rg-count-${count.index + 1}"
  location = "eastus"
}
```

### 2. For_Each with Map
```hcl
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups_map
  name     = each.key
  location = each.value
}
```

### 3. Converting List to Set via `toset()`
`for_each` requires distinct keys. Passing a raw list will cause a syntax validation error. Use `toset()` to guarantee unique keys:
```hcl
resource "azurerm_storage_account" "sa" {
  for_each                 = toset(var.storage_names_list)
  name                     = each.key
  resource_group_name      = "rg-shared"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

---

## 🛠️ Step-by-Step Getting Started Guide

### Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (v1.5.0+).

### 1. Format Code
```bash
terraform fmt
```

### 2. Initialize Working Directory
```bash
terraform init -backend=false
```

### 3. Validate Configuration
```bash
terraform validate
```

### 4. Review Plan (Educational Documentation)
```bash
terraform plan -var-file="terraform.tfvars.example"
```

### 5. Apply Changes (Educational Documentation)
```bash
terraform apply
```
> ⚠️ **IMPORTANT**: In production, `terraform apply` requires manual confirmation. In this educational repository, no cloud deployment is executed.

---

## 🔄 Terraform Resource Lifecycle & Destruction Concepts

1. **Destroying Loop Elements**:
   When using `for_each`, removing a single entry from `resource_groups_map` causes Terraform to propose destroying **only** that specific resource group.
2. **Accidental Mass Deletion with Count**:
   With `count`, deleting the first item from a list forces Terraform to re-index all subsequent items, which can trigger accidental destruction and recreation of unrelated resources. This is why `for_each` is the industry standard for production collections.
3. **Reviewing Plans**:
   Always check the exact resource keys identified in `terraform plan` before applying changes.

---

## 🤖 CI/CD Automation (GitHub Actions)

This repository includes a continuous integration workflow in `.github/workflows/validate.yml` that validates syntax across the root module and all 4 example directories on every push and pull request.

---

## 👨‍💻 Author Information

- **Developer**: Vishal Yadav (`vishalnik002-git`)
- **Education**: MCA @ Galgotias University (2025–2027) | BCA @ MGKVP (2022–2025)
- **Role**: DevOps Intern @ DevOps Insiders
- **GitHub Profile**: [https://github.com/vishalnik002-git](https://github.com/vishalnik002-git)
