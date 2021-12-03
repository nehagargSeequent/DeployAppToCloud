output "pgsql_admin" {
  value = azurerm_postgresql_server.pgsql_server.administrator_login
}

output "pgsql_admin_password" {
  value     = azurerm_postgresql_server.pgsql_server.administrator_login_password
  sensitive = true
}

output "pgsql_fqdn" {
  value = azurerm_postgresql_server.pgsql_server.fqdn
}

output "pgsql_server_name" {
  value = azurerm_postgresql_server.pgsql_server.name
}