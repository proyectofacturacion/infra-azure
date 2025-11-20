##############################################
# BASE DE DATOS POSTGRESQL - MULTI AMBIENTE
##############################################

locals {
  postgres_name = "pgprojfactu-${var.environment}"
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = local.postgres_name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  administrator_login = "adminprojfactu"

  administrator_password = (
    var.environment == "dev" ? var.postgres_password_dev :
    var.environment == "qa"  ? var.postgres_password_qa :
                               var.postgres_password_prd
  )

  sku_name = (
    var.environment == "prd" ?
    "GP_Standard_D2ds_v5" :
    "B_Standard_B1ms"
  )

  version = "16"

  storage_mb = (
    var.environment == "prd" ? 65536 : 32768
  )

  backup_retention_days = (
    var.environment == "prd" ? 7 : 1
  )

  geo_redundant_backup_enabled = (
    var.environment == "prd" ? true : false
  )

  zone = "1"
}

output "postgres_hostname" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}
