# Creates a NSG with the specified rules.
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg-name
  resource_group_name = var.resource-group
  location            = var.deploy-location
}

# Creates an inbound TCP rule for each port provided by the deployments variables.
resource "azurerm_network_security_rule" "nsg-inbound-tcp-rules" {
  count                       = length(var.inbound-tcp-rules)
  network_security_group_name = var.nsg-name
  resource_group_name         = var.resource-group
  name                        = "inbound-rule-${count.index}"
  priority                    = (100 * (count.index + 1))
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = element(var.inbound-tcp-rules, count.index)
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  depends_on                  = [azurerm_network_security_group.nsg]
}