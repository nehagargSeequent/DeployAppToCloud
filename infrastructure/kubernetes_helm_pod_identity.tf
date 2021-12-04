resource "kubernetes_namespace" "aad_pod_identity" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
  metadata {
    name = "azure-identity"
    labels = {
      name = "azure-identity"
    }
  }
}

resource "helm_release" "aad_pod_identity" {
  name       = "aad-pod-identity"
  repository = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart      = "aad-pod-identity"
  version    = "3.0.3"
  namespace  = kubernetes_namespace.aad_pod_identity.metadata[0].name

  set {
    name  = "installCRDs"
    value = true
  }

  set {
    name  = "azureIdentity.resourceID"
    value = azurerm_user_assigned_identity.pod_identity.id
  }

  set {
    name  = "azureIdentity.clientID"
    value = azurerm_user_assigned_identity.pod_identity.client_id
  }

  set {
    name  = "azureIdentity.type"
    value = "0"
  }

  set {
    name  = "azureIdentity.binding.selector"
    value = var.kv_pod_identity
  }

  set {
    name  = "azureIdentity.binding.name"
    value = var.kv_pod_identity
  }
}
