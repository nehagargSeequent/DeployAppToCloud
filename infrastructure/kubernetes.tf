resource "azurerm_kubernetes_cluster" "k8s" {
  name                = local.common_resource_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  node_resource_group = "${azurerm_resource_group.resource_group.name}-nodes"
  dns_prefix          = local.common_resource_name

  # Provide IPs to be able to restrict access to AKS service. Don't open it.
  # api_server_authorized_ip_ranges = var.kubernetes.authorized_ip_ranges

  default_node_pool {
    name                 = "default"
    node_count           = var.kubernetes.node_count
    vm_size              = var.kubernetes.vm_size
    vnet_subnet_id       = azurerm_subnet.k8s_subnet.id
    # High availability can be ensured by keeping cluster nodes in different availability zones.
    availability_zones   = var.kubernetes.vm_zones
    enable_auto_scaling  = var.kubernetes.enable_auto_scaling
    min_count            = var.kubernetes.min_count
    max_count            = var.kubernetes.max_count
  }

  # It would create a cluster with managed identities which could be used to 
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  role_based_access_control {
    enabled = true
  }
}