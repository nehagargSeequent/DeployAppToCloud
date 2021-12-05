resource "azurerm_resource_group" "postgres_resource_group" {
  name     = var.postgres.server_resource_group_name
  location = var.postgres.server_location
}

# Generate random string to be used for postgresql server Password
resource "random_password" "admin_password" {
  length  = 32
  special = true
}

resource "azurerm_postgresql_server" "pgsql_server" {
  name                = var.postgres.server_name
  location            = azurerm_resource_group.postgres_resource_group.location
  resource_group_name = azurerm_resource_group.postgres_resource_group.name

  # Create mode can be Default or Replica. Replica create_mode could be used to define a failover server.
  # You will need to provide the server id of the source database server while defining the failover server.
  create_mode = "Default"
  #creation_source_server_id = var.creation_source_server_id

  sku_name = var.postgres.sku_name

  storage_mb            = 5120
  backup_retention_days = 7

  # The database server backup would be enabled geographically which would protect data loss against failures.
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = var.postgres.administrator_login
  administrator_login_password = random_password.admin_password.result
  version                      = "11"
  ssl_enforcement_enabled      = "false"
  tags = var.tags
}

# Allowing AKS cluster subnet to access database
resource "azurerm_postgresql_virtual_network_rule" "pgsql_vnet_rule" {
  name                = "postgresql-vnet-rule"
  resource_group_name = azurerm_resource_group.postgres_resource_group.name
  server_name         = azurerm_postgresql_server.pgsql_server.name
  subnet_id           = azurerm_subnet.k8s_subnet.id
}

# Adding pgsql server login username as a secret to Key Vault 
resource "azurerm_key_vault_secret" "pgsql_server_admin_username" {
  name         = "pgsql-username"
  value        = "${var.postgres.administrator_login}@${azurerm_postgresql_server.pgsql_server.name}"
  key_vault_id = azurerm_key_vault.key_vault.id
  depends_on   = [azurerm_role_assignment.key_vault_admin]
}

# Adding pgsql server login password as a secret to Key Vault 
resource "azurerm_key_vault_secret" "pgsql_server_admin_password" {
  name         = "pgsql-password"
  value        = azurerm_postgresql_server.pgsql_server.administrator_login_password
  key_vault_id = azurerm_key_vault.key_vault.id
  depends_on   = [azurerm_role_assignment.key_vault_admin]
}