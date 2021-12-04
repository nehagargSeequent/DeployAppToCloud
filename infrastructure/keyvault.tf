resource "azurerm_key_vault" "key_vault" {
  name                = "${var.resource_prefix}-vault"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tenant_id           = var.azure.tenant_id
  sku_name            = "standard"

  # Access to key vault is provided via RBAC. Or set false (default) to use Access Policies.
  # Using RBAC here so that the user could read-write KV secrets via permissions inherited from the subscription.
  enable_rbac_authorization = "true"
  tags                      = var.tags

  # Not restricting access below so that you won't have issue in creating and accessing secrets.
  # Ideally below should be in place to allow access to only authorized IPs or CIDRs.

  #   network_acls {
  #     bypass         = "AzureServices"
  #     default_action = "Deny"
  #     ip_rules       = var.keyvault.authorized_ip_ranges
  #     virtual_network_subnet_ids = [
  #       azurerm_subnet.k8s_subnet.id
  #     ]
  #   }

}