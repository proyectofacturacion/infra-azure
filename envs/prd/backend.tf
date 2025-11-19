terraform {
  backend "azurerm" {
    resource_group_name  = "rg-cicd-terraform-app-projfactu" # Reemplazar por projfactu
    storage_account_name = "tfstateprojfactu"                # Reemplazar por projfactu
    container_name       = "tfstate"
    key                  = "prd/terraform.tfstate"
  }
}