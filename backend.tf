terraform {
  backend "azurerm" {
    resource_group_name  = "rg-cicd-terraform-app-proyectofacturacion" # Reemplazar por proyectofacturacion
    storage_account_name = "tfstateproyectofacturacion"                # Reemplazar por proyectofacturacion
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}