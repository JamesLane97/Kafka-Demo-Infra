#
resource "azurerm_container_app" "container-app" {
  name                         = join("-", [var.app-name, "container-app"])
  container_app_environment_id = var.env-id
  resource_group_name          = var.resource-group
  revision_mode                = "Single"

  ingress {
    external_enabled = var.external
    target_port      = var.port

    #With revision mode set to single, traffic weight is not required. Currently unresolved in this version of Terraform.
    traffic_weight {
      percentage = 100
    }
  }

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