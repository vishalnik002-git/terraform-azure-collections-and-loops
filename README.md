# 🔁 Terraform Loops & Collections (`list`, `set`, `map`)

[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Microsoft_Azure-0078D4?style=flat&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![HCL Collections](https://img.shields.io/badge/HCL-Data_Structures-orange)](https://developer.hashicorp.com/terraform/language/expressions/types)

---

## 📌 Project Overview

This project explores the core **Data Structures and Collection Types** in HashiCorp Configuration Language (HCL):
1. **`list(string)`** — Ordered collection of values.
2. **`set(string)`** — Unordered collection of unique values.
3. **`map(string)`** — Key-value pairs for flexible configuration.

It demonstrates how to iterate over these structures dynamically using Terraform's **`for_each`** meta-argument to provision Azure Resource Groups across different locations.

---

## 🏗️ Architecture & Collection Breakdown

```text
Collection Types in Action:
  ├── list(string) ───[toset()]───► for_each ───► Resource Groups in East US
  ├── set(string)  ───────────────► for_each ───► Resource Groups in West US
  └── map(string)  ───────────────► for_each ───► Resource Groups (Location mapped per key)
```

### 1. `list(string)` with `toset()`
* **Concept:** Terraform's `for_each` only accepts `set` or `map`. A list cannot be passed directly to `for_each` because list elements are identified by index, which can cause resource churn if the list order changes.
* **Implementation:** `toset(var.rg_list)` converts the list to a unique set safely for iteration.

### 2. `set(string)`
* **Concept:** A native set guarantees all elements are unique and unordered.
* **Implementation:** Passed directly to `for_each = var.rg_set` without any type conversion.

### 3. `map(string)`
* **Concept:** Key-value pairs allow mapping each resource name (`each.key`) to a specific target Azure region (`each.value`).
* **Implementation:** Provides complete flexibility to place resources in distinct geographic regions within a single loop block.

---

## 📁 Repository Structure

```text
.
├── main.tf              # Resource definitions iterating over collections
├── variable.tf          # Type declarations (list, set, map)
├── terraform.tfvars     # Sample input values for list, set, and map
├── provider.tf          # AzureRM provider configuration
├── .gitignore           # Git ignore rules for state and secret files
└── README.md            # Project documentation
```

---

## 🚀 How to Run

### Prerequisites
* [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) authenticated (`az login`)
* [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (>= 1.5.0)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/vishalnik002-git/terraform-loops-collections.git
cd terraform-loops-collections

# 2. Authenticate to Azure
az login

# 3. Initialize Terraform
terraform init

# 4. Preview the infrastructure plan
terraform plan

# 5. Apply the resources
terraform apply -auto-approve
```

---

## 🧹 Clean Up

To destroy all provisioned test resource groups:

```bash
terraform destroy -auto-approve
```

---

## 👤 Author
* **Vishal Yadav** — [GitHub Profile](https://github.com/vishalnik002-git) | [LinkedIn](https://www.linkedin.com/in/vishal-yadav002)
