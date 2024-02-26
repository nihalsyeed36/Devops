# Public IP for App gateway

resource "azurerm_public_ip" "tf-agw_pip" {
  name = "${var.name}-${var.env}-${var.purpose}-we-pip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
}

# Create Application Gateway
resource "azurerm_application_gateway" "tf-agw" {
  name                = "${var.name}-${var.env}-${var.purpose}-we-agw"
  resource_group_name = var.resource_group_name
  location            = var.location
  enable_http2        = true
  lifecycle {
    prevent_destroy = true
    ignore_changes = [ redirect_configuration, frontend_port,ssl_certificate, backend_address_pool, backend_http_settings, http_listener, request_routing_rule, probe, tags, url_path_map]
  }
  sku {
    name     = var.appgw_sku_name 
    tier     = var.appgw_sku_tier
    capacity = var.appgw_capacity
  }  
  gateway_ip_configuration {
    name      = "agwipconfig"
    subnet_id = var.subnet_agw_id
  }
  
  #frontend_port {
  #   name = "${var.name}-${var.env}-${var.purpose}-we-01-frontendport"
  #   port = 443
  #}
  frontend_port {
    name = "${var.name}-${var.env}-${var.purpose}-we-02-frontendport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appgwfrontendip"
    public_ip_address_id = azurerm_public_ip.tf-agw_pip.id
  }

  backend_address_pool {
    name= "${var.name}-${var.env}-${var.purpose}-we-01-backendpool"
  }

  backend_http_settings {
    name                  = "${var.name}-${var.env}-${var.purpose}-we-01-backendhttp"
    cookie_based_affinity = "Disabled"
    path                  = ""
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
    probe_name            = "${var.name}-${var.env}-${var.purpose}-we-01-probe"
  } 

# Configure WAF Rules 
waf_configuration{
     enabled=true
     firewall_mode ="Prevention"
     rule_set_type = "OWASP"
     rule_set_version ="3.1"
     request_body_check=false
  }
 
  ssl_policy{
     policy_type="Custom"
     min_protocol_version="TLSv1_2"
     cipher_suites= ["TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256", "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384", "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA", "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA","TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256", "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384", "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384", "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256", "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA", "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA"]
  }

   #http_listener {
    #name                           = "${var.name}-${var.env}-${var.purpose}-we-01-httplistener"
    #frontend_ip_configuration_name = "appgwfrontendip"
    #frontend_port_name             = "${var.name}-${var.env}-${var.purpose}-we-01-frontendport"
    #protocol                       = "Https"
  #}
  http_listener {
    name                           = "${var.name}-${var.env}-${var.purpose}-we-02-httplistener"
    frontend_ip_configuration_name = "appgwfrontendip"
    frontend_port_name             = "${var.name}-${var.env}-${var.purpose}-we-02-frontendport"
    protocol                       = "Http"
  }

  #request_routing_rule {
  #  name                       = "${var.name}-${var.env}-${var.purpose}-we-01-requestroutingrule"
  #  rule_type                  = "Basic"
  #  http_listener_name         = "${var.name}-${var.env}-${var.purpose}-we-01-httplistener"
  #  backend_address_pool_name  = "${var.name}-${var.env}-${var.purpose}-we-01-backendpool"
  #  backend_http_settings_name = "${var.name}-${var.env}-${var.purpose}-we-01-backendhttp"
  #}
  request_routing_rule {
    name                       = "${var.name}-${var.env}-${var.purpose}-we-02-requestroutingrule"
    rule_type                  = "Basic"
    http_listener_name         = "${var.name}-${var.env}-${var.purpose}-we-02-httplistener"
    backend_address_pool_name  = "${var.name}-${var.env}-${var.purpose}-we-01-backendpool"
    backend_http_settings_name = "${var.name}-${var.env}-${var.purpose}-we-01-backendhttp"
    priority = 10
  }
 
  probe {
    name = "${var.name}-${var.env}-${var.purpose}-we-01-probe"
    protocol = "Http"
    host = "localhost"
    path = "/healthz"
    interval = 30
    timeout = 60
    unhealthy_threshold = 3
  }

  tags = var.tags
}

