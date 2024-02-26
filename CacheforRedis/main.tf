resource "azurerm_redis_cache" "tf-rec" {
  name                = "${var.name}-${var.env}-${var.purpose}-we-rec"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 1
  family              = var.family 
  sku_name            = var.redis_sku_name
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  public_network_access_enabled = false
  
  redis_configuration {
  }
  timeouts {
    create = "60m"
  }

  tags = var.tags
}

#Private DNS zone for Redis
resource "azurerm_private_dns_zone" "tf-recdns" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = var.nw_resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "tf-recvnetlink" {
  name                  = "rec-vnet-link"
  resource_group_name   = var.nw_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.tf-recdns.name
  virtual_network_id    = var.virtual_network_id
}

#Private endpoint connection
resource "azurerm_private_endpoint" "tf-recept" {
  name                = "${var.name}-${var.env}-network-we-rec-ept"
  location            = var.location
  resource_group_name = var.nw_resource_group_name
  custom_network_interface_name = "${var.name}-${var.env}-network-we-rec-ept-nic"
  subnet_id           = var.app_subnet_id

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.tf-recdns.id]
  }

  private_service_connection {
    name                           = "rec-privateserviceconnection"
    private_connection_resource_id = azurerm_redis_cache.tf-rec.id
    subresource_names = ["redisCache"]
    is_manual_connection           = false
  }
}