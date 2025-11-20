#########################################
# BACKEND SPRING BOOT - MULTI AMBIENTE
#########################################

resource "azurerm_container_app" "backend" {
  name                         = "aca-ms-${local.idapp}-${var.environment}"
  resource_group_name          = data.azurerm_resource_group.main.name
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "backend"
      image  = "${data.azurerm_container_registry.acr.login_server}/backend:${var.environment}"
      cpu    = 1.0
      memory = "2Gi"

      env {
        name  = "SPRING_PROFILES_ACTIVE"
        value = var.environment
      }

      env {
        name  = "DB_HOST"
        value = azurerm_postgresql_flexible_server.postgres.fqdn
      }

      env {
        name  = "DB_USER"
        value = "adminprojfactu"
      }

      env {
        name = "DB_PASS"
        value = (
          var.environment == "dev" ? var.postgres_password_dev :
          var.environment == "qa"  ? var.postgres_password_qa :
                                     var.postgres_password_prd
        )
      }

      env {
        name  = "SERVER_PORT"
        value = "8080"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 8080

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      template[0].container[0].image,
    ]
  }

  depends_on = [
    azurerm_container_app_environment.aca_env,
    data.azurerm_container_registry.acr,
    azurerm_postgresql_flexible_server.postgres
  ]
}

resource "azurerm_role_assignment" "backend_acr_pull" {
  principal_id         = azurerm_container_app.backend.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = data.azurerm_container_registry.acr.id
}
