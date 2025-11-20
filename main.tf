# Resource Group donde ya tienes todo
data "azurerm_resource_group" "main" {
  name = "rg-cicd-terraform-app-${local.idapp}"
}

# ACR global que ya creaste (acrprojfactu)
data "azurerm_container_registry" "acr" {
  name                = "acr${local.idapp}"
  resource_group_name = data.azurerm_resource_group.main.name
}

# Entorno de Container Apps por ambiente
resource "azurerm_container_app_environment" "aca_env" {
  name                = "aca-env-${local.idapp}-${var.environment}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}
