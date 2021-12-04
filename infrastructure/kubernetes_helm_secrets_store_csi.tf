resource "kubernetes_namespace" "csi-secrets-store" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
  metadata {
    name = "csi-driver"
    labels = {
      name = "csi-driver"
    }
    annotations = {
      "linkerd.io/inject" = "enabled"
    }
  }
}

resource "helm_release" "csi-secrets-store-provider-azure" {
  name       = "csi-secrets-store-provider-azure"
  repository = "https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/charts"
  chart      = "csi-secrets-store-provider-azure"
  version    = "0.0.17"
  namespace  = kubernetes_namespace.csi-secrets-store.metadata[0].name
}
