resource "azurerm_resource_group" "database_resource_group" {
  name     = var.database.server_resource_group_name
  location = var.database.server_location
}

# Generate random string to be used for postgresql server Password
resource "random_string" "admin_password" {
  length  = 32
  special = true
}

resource "azurerm_postgresql_server" "pgsql_server" {
  name                = var.database.server_name
  location            = azurerm_resource_group.database_resource_group.location
  resource_group_name = azurerm_resource_group.database_resource_group.name

  # Create mode can be Default or Replica. Replica create_mode could be used to define a failover server.
  # You will need to provide the server id of the source database server while defining the failover server.
  create_mode               = "Default"
  #creation_source_server_id = var.creation_source_server_id

  sku_name = var.database.postgres_sku_name

  storage_mb            = 5120
  backup_retention_days = 7

  # The database server backup would be enabled geographically which would protect data loss against failures.
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = var.database.administrator_login
  administrator_login_password = random_string.admin_password.result
  version                      = "11"
  ssl_enforcement_enabled      = "true"

  tags = var.tags
}

resource "azurerm_postgresql_database" "pgsql_server_database" {
  name                = var.database.database_name
  resource_group_name = azurerm_resource_group.database_resource_group.name
  server_name         = azurerm_postgresql_server.pgsql_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

