resource "azurerm_kubernetes_cluster" "k8s" {
  name                = local.common_resource_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  node_resource_group = "${azurerm_resource_group.resource_group.name}-nodes"
  dns_prefix          = local.common_resource_name

  api_server_authorized_ip_ranges = var.kubernetes.authorized_ip_ranges

  auto_scaler_profile {
    skip_nodes_with_system_pods = false
  }

  default_node_pool {
    name                 = "default"
    node_count           = 2
    vm_size              = "Standard_D2s_v3"
    enable_auto_scaling  = "true"
    min_count            = 1
    max_count            = 3
    # below could be uncommented if need cluster nodes in different zones to make the application resilient.
    # availability_zones   = [1, 2, 3]  
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  role_based_access_control {
    enabled = true
  }
}