resource "azurerm_kubernetes_cluster" "tf-aks" {
  name                = "${var.name}-${var.env}-${var.purpose}-we-aks"
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.name}-${var.env}-${var.purpose}-we-dns"
  node_resource_group = "${var.name}-${var.env}-aks-we-rgp"
  sku_tier = "Free"
  oidc_issuer_enabled =  true
  workload_identity_enabled = true

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    zones  = [1, 2, 3]
    enable_auto_scaling = false
    vnet_subnet_id  = var.subnet_aks_id
    }

  #identity {
  #  type = "UserAssigned"
  #  identity_ids = [azurerm_user_assigned_identity.tf-aks-identity.id]
  #}

  service_principal {
    client_id = var.client_id
    client_secret = var.client_secret
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin     = "azure"
    dns_service_ip     = var.aks_dns_service_ip
    service_cidr       = var.aks_service_cidr
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    managed = true
  }
  
  ingress_application_gateway {
    gateway_id = var.app_gw_id
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  storage_profile {
    blob_driver_enabled = true
  }

  tags = var.tags
}

#  TODO namespace
#resource "azurerm_" "tf-aks-namespace" {
#  metadata {
#     name = var.namespace_name
#  }
#}

resource "azurerm_kubernetes_cluster_node_pool" "user_node_pool_1" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.tf-aks.id
  name                = "usernp1"
  node_count          = var.system_node_count
  mode                = "User"
  vm_size             = "Standard_D4s_v3"
  zones  = [1, 2, 3]
  enable_auto_scaling = false
  vnet_subnet_id  = var.subnet_aks_id
}

resource "azurerm_role_assignment" "tf-aks-to-acr" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = var.aks_spn_objectid
}

resource "azurerm_role_assignment" "tf-aks-to-blob-storage" {
  scope                = var.solution_stg_id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = var.aks_spn_objectid
}

resource "azurerm_user_assigned_identity" "tf-aks-identity" {
  location            = var.location
  name                = var.aks_identity_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "tf-aks-to-kv" {
  scope                = var.keyvault_id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.tf-aks-identity.principal_id
}

resource "azurerm_federated_identity_credential" "tf-aks-fed-identity-cred" {
  name                = "aks-federated-identity"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://westeurope.oic.prod-aks.azure.com/0ae51e19-07c8-4e4b-bb6d-648ee58410f4/44db05bf-abf1-4d4e-b165-ee13bbf453bb/"
  parent_id           = azurerm_user_assigned_identity.tf-aks-identity.id
  subject             = "system:serviceaccount:acona:azure-kv-sa"
}