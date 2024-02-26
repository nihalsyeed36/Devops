resource "azurerm_container_registry" "tf-acr" {
  name                = "${var.name}${var.env}${var.purpose}weacr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
  network_rule_set {
    default_action = "Deny"
    ip_rule = [ 
      {
      action = "Allow"
      ip_range = "103.205.152.0/22"
      },
      {
      action = "Allow"
      ip_range = "139.15.0.0/16"
      },
      {
      action = "Allow"
      ip_range = "194.39.218.0/23"
      },
      {
      action = "Allow"
      ip_range = "193.141.57.0/24"
      },
      {
      action = "Allow"
      ip_range = "193.108.217.0/24"
      },
      {
      action = "Allow"
      ip_range = "149.226.0.0/16"
      }
    ]
  virtual_network {
    action  = "Allow"
    subnet_id = var.subnet_id
    }
  }
  
  tags = var.tags
}