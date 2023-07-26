resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = join("-", [var.vm-name, "public-key"])
  location  = var.deploy-location
  parent_id = var.parent-id
}

output "public-key" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
}

output "private-key" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).privateKey
}