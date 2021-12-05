resource "kubernetes_namespace" "app_ns" {
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
  metadata {
    annotations = {
      name = "azure-golang"
    }
    name = "azure-golang"
  }
}

resource "kubernetes_config_map" "db_config" {
  depends_on = [
    azurerm_postgresql_server.pgsql_server
  ]
  metadata {
    name      = "golang-database-config"
    namespace = kubernetes_namespace.app_ns.metadata.0.name
  }
  data = {
    VTT_DBNAME = "golangDb"
    VTT_DBPORT = 5432
    VTT_DBHOST = azurerm_postgresql_server.pgsql_server.fqdn
  }
}