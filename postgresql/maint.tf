#Private DNS Zone for PSQL
resource "azurerm_private_dns_zone" "tf-psqldns" {
  name                = "${var.name}.postgres.database.azure.com"
  resource_group_name = var.nw_resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "tf-vnetlink" {
  name                  = "pql-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.tf-psqldns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.nw_resource_group_name
}

#PSQL
resource "azurerm_postgresql_flexible_server" "tf-postgres" {
    for_each = var.postgresql
  name                = "${var.name}-${var.env}-${each.value.purpose}-we-0${each.value.num}-pql"
  location            = each.value.location
  resource_group_name = var.resource_group_name

  delegated_subnet_id    = var.subnet_db_id
  private_dns_zone_id    = azurerm_private_dns_zone.tf-psqldns.id

  administrator_login          = each.value.administrator_login
  administrator_password = each.value.administrator_password

  sku_name   = each.value.sku_name
  storage_mb = each.value.storage_mb
  version    = each.value.version 

  backup_retention_days         =each.value.backup_retention_days 
  geo_redundant_backup_enabled  = each.value.geo_redundant_backup_enabled

  lifecycle {
      ignore_changes = [
        zone,
        high_availability.0.standby_availability_zone
      ]
  }
  depends_on = [azurerm_private_dns_zone_virtual_network_link.tf-vnetlink]
  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_configuration" "tf-postgres-configuration-1" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.tf-postgres["pqldb01"].id
  value     = "UUID-OSSP"
}
