#########################################
# FRONTEND ANGULAR - MULTI AMBIENTE
#########################################

resource "azurerm_container_app" "frontend" {
  name                         = "aca-fe-${local.idapp}-${var.environment}"
  resource_group_name          = data.azurerm_resource_group.main.name
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "frontend"
      image  = "${data.azurerm_container_registry.acr.login_server}/frontend:${var.environment}"
      cpu    = 0.5
      memory = "1Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80

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
    data.azurerm_container_registry.acr
  ]
}

resource "azurerm_role_assignment" "frontend_acr_pull" {
  principal_id         = azurerm_container_app.frontend.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = data.azurerm_container_registry.acr.id
}
