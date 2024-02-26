resource "azurerm_cognitive_account" "tf-oai" {
  kind                               = "OpenAI"
  location                           = var.location
  name                               = "${var.name}-${var.env}-${var.purpose}-we-oai"
  resource_group_name                = var.resource_group_name
  sku_name                           = var.oai_sku
  custom_subdomain_name              = var.oai_custom_subdomain_name
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

resource "azurerm_cognitive_deployment" "tf-oai-gpt-35-turbo" {
  name                 = "acona-gpt-35-turbo"
  cognitive_account_id = azurerm_cognitive_account.tf-oai.id
  model {
    format  = "OpenAI"
    name    = "gpt-35-turbo"
    version = "0301"
  }

  rai_policy_name = "Microsoft.Default"

  scale {
    type = "Standard"
    capacity = "120"
  }
}

#Private DNS zone for OpenAI
resource "azurerm_private_dns_zone" "tf-oaidns" {
  name                = "privatelink.openai.azure.com"
  resource_group_name = var.nw_resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "tf-oaivnetlink" {
  name                  = "oai-vnet-link"
  resource_group_name   = var.nw_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.tf-oaidns.name
  virtual_network_id    = var.virtual_network_id
}

#Private endpoint connection
resource "azurerm_private_endpoint" "tf-oaiept" {
  name                = "${var.name}-${var.env}-network-we-oai-ept"
  location            = var.location
  resource_group_name = var.nw_resource_group_name
  custom_network_interface_name = "${var.name}-${var.env}-network-we-oai-ept-nic"
  subnet_id           = var.app_subnet_id

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.tf-oaidns.id]
  }

  private_service_connection {
    name                           = "oai-privateserviceconnection"
    private_connection_resource_id = azurerm_cognitive_account.tf-oai.id
    subresource_names = ["account"]
    is_manual_connection           = false
  }
}

