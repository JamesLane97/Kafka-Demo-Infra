# Creates a public ip for the VM NIC.
resource "azurerm_public_ip" "vm-public-ip" {
  name                = join("-", [var.vm-name, "public-ip"])
  resource_group_name = var.resource-group
  location            = var.deploy-location
  allocation_method   = "Static"
}

# Creates a NIC for the VM.
resource "azurerm_network_interface" "vm-nic" {
  name                = join("-", [var.vm-name, "NIC"])
  resource_group_name = var.resource-group
  location            = var.deploy-location
  ip_configuration {
    name                          = join("-", [var.vm-name, "internal"])
    subnet_id                     = var.subnet-id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-public-ip.id
  }

}

# Creates the VM.
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm-name
  resource_group_name             = var.resource-group
  location                        = var.deploy-location
  size                            = var.vm-size
  network_interface_ids           = [azurerm_network_interface.vm-nic.id]
  admin_username                  = "adminuser"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "adminuser"
    public_key = var.vm-public-key
  }

  os_disk {
    name                 = join("-", [var.vm-name, "OS"])
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}