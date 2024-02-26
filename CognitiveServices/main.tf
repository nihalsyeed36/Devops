resource "azurerm_cognitive_account" "tf-cgs" {
  name                = "${var.name}-${var.env}-${var.purpose}-we-cgs"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.cgs_sku
  kind                = "CognitiveServices"
  custom_subdomain_name = var.custom_subdomain_name
  public_network_access_enabled = false
  network_acls {
    default_action = "Deny"
    ip_rules = []
  #  virtual_network_rules {
  #    subnet_id = var.subnet_id
  #  }
  }
  tags = var.tags
}

#Private DNS zone for CGS
resource "azurerm_private_dns_zone" "tf-cgsdns" {
  name                = "privatelink.cognitiveservices.azure.com"
  resource_group_name = var.nw_resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "tf-cgsvnetlink" {
  name                  = "cgs-vnet-link"
  resource_group_name   = var.nw_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.tf-cgsdns.name
  virtual_network_id    = var.virtual_network_id
}


#Private endpoint connection
resource "azurerm_private_endpoint" "tf-cgsept" {
  name                = "${var.name}-${var.env}-network-we-cgs-ept"
  location            = var.location
  resource_group_name = var.nw_resource_group_name
  custom_network_interface_name = "${var.name}-${var.env}-network-we-cgs-ept-nic"
  subnet_id           = var.app_subnet_id

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.tf-cgsdns.id]
  }

  private_service_connection {
    name                           = "cgs-privateserviceconnection"
    private_connection_resource_id = azurerm_cognitive_account.tf-cgs.id
    subresource_names = ["account"]
    is_manual_connection           = false
  }
}


