#
resource "azurerm_log_analytics_workspace" "analytics-workspace" {
  name                = join("-", [var.env-name, "workspace"])
  resource_group_name = var.resource-group
  location            = var.deploy-location
  sku                 = "PerGB2018"
  retention_in_days   = var.retention
}

#
resource "azurerm_container_app_environment" "container-app-enviroment" {
  name                       = join("-", [var.env-name, "container-app-env"])
  resource_group_name        = var.resource-group
  location                   = var.deploy-location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.analytics-workspace.id
}