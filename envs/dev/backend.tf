terraform {
  backend "azurerm" {
    resource_group_name  = "rg-cicd-terraform-app-projfactu"
    storage_account_name = "tfstateprojfactu"
    container_name       = "tfstate"
    key                  = "infra-${var.environment}.tfstate"
  }
}

