locals {
  idapp = "projfactu" # projfactu
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "212505e5-da0e-4f00-850b-9d48a4f06e50" # Id de suscripción
}