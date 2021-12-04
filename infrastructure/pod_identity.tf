# The identity pods would use to access key vault secrets.
resource "azurerm_user_assigned_identity" "pod_identity" {
  name                = "${local.common_resource_name}-${var.kv_pod_identity}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}