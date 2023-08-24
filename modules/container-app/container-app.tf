#
resource "azurerm_container_app" "container-app" {
  name                         = join("-", [var.app-name, "container-app"])
  container_app_environment_id = var.env-id
  resource_group_name          = var.resource-group
  revision_mode                = "Single"

  template {
    container {
      name    = var.app-name
      image   = var.image
      cpu     = var.cpu
      memory  = var.memory
      command = var.commands
    }
    max_replicas = var.replicas-max
    min_replicas = var.replicas-min
  }

}