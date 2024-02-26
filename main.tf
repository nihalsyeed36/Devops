# Resource Group Configuration
module "resource_group" {
  source   = "./Resourcegroup"
  resource_groups = var.resource_groups
  name = var.name
  env = var.env
  tags  = var.tags
  }

# VNET Configuration
module "virtual_network"  {
  source = "./VirtualNetwork"
  virtual_network = var.virtual_network
  name = var.name
  env = var.env
  virtual_network_location  = var.virtual_network_location
  virtual_network_address_space = var.virtual_network_address_space
  depends_on=[module.resource_group]
  resource_group_name=module.resource_group.rg_name_out.rg03
  tags  = var.tags
}

module "subnet" {
  source = "./subnet"
  subnet = var.subnet
  name = var.name
  env = var.env
  depends_on = [module.virtual_network]
  resource_group_name = module.resource_group.rg_name_out.rg03
  virtual_network_name = module.virtual_network.vnet_name_out
}

module "network_security_group"  {
  source = "./NSG"
  network_security_group = var.network_security_group
  name = var.name
  env = var.env
  depends_on = [module.subnet]
  resource_group_name = module.resource_group.rg_name_out.rg03
  tags  = var.tags
}

module "network_security_group_association_01" {
  source = "./NSGAsso"
  subnet_id = module.subnet.snt_id_out.snet01
  nsg_id = module.network_security_group.nsg_id_out.nsg01
}

module "network_security_group_association_02" {
  source = "./NSGAsso"
  subnet_id = module.subnet.snt_id_out.snet02
  nsg_id = module.network_security_group.nsg_id_out.nsg02
}

module "network_security_group_association_03" {
  source = "./NSGAsso"
  subnet_id = module.subnet.snt_id_out.snet03
  nsg_id = module.network_security_group.nsg_id_out.nsg03
}

module "network_security_group_association_05" {
  source = "./NSGAsso"
  subnet_id = module.subnet.snt_id_out.snet05
  nsg_id = module.network_security_group.nsg_id_out.nsg05
}


# Log analytics workspace Configuration

module "loganalyticsworkspace" {
  source = "./LGW"
  log_analytics_workspace = var.log_analytics_workspace
  name = var.name
  env = var.env
  resource_group_name = module.resource_group.rg_name_out.rg01
  depends_on = [module.network_security_group]
  tags  = var.tags
}

# Keyvault Configuration
module "key_vault" {
  source = "./Keyvault"
  key_vault = var.key_vault
  name = var.name
  env = var.env
  virtual_network_subnet_ids  = [module.subnet.snt_id_out.snet01, module.subnet.snt_id_out.snet02, module.subnet.snt_id_out.snet03, module.subnet.snt_id_out.snet04]
  depends_on=[module.resource_group]
  tags  = var.tags
  #resource_group_name=module.resource_group.rg_name_out.rg01
}

module "key_vault_secret" {
  source = "./KVSecrets"
  inter_service_auth_username = var.inter_service_auth_username
  inter_service_auth_password = var.inter_service_auth_password
  mam_username = var.mam_username
  mam_client_id = var.mam_client_id
  mam_password = var.mam_password
  postgres_username = var.postgres_username
  postgres_password = var.postgres_password
  redis_password = var.redis_password
  blob_storage_connection_string = var.blob_storage_connection_string
  azure_ad_client_id = var.azure_ad_client_id
  azure_ad_client_secret = var.azure_ad_client_secret
  azure_open_ai_api_key = var.azure_open_ai_api_key
  azure_cognitive_services_api_key = var.azure_cognitive_services_api_key
  solution_kv_id = module.key_vault.key_vault_out_id.kv02
  depends_on=[module.key_vault]
}

# Storage account Configuration
module "storage_account"  {
  source = "./Storage"
  storage_account = var.storage_account
  name = var.name
  env = var.env
  depends_on=[module.resource_group]
  virtual_network_subnet_ids  = [module.subnet.snt_id_out.snet01, module.subnet.snt_id_out.snet02, module.subnet.snt_id_out.snet03, module.subnet.snt_id_out.snet04]
  tags  = var.tags
  #resource_group_name=module.resource_group.rg_name_out.rg01
}

# AGW Configuration
module "appgateway" {
  source = "./AppGateway"
  name = var.name
  env = var.env
  purpose = var.purpose
  location = var.location
  appgw_sku_name  = var.appgw_sku_name
  appgw_sku_tier  = var.appgw_sku_tier
  appgw_capacity  = var.appgw_capacity
  subnet_agw_id = module.subnet.snt_id_out.snet03
  depends_on = [module.storage_account]
  resource_group_name = module.resource_group.rg_name_out.rg02
  tags  = var.tags
}

# AKS Configuration
module "aks"  {
  source = "./AKS"
  aks = var.aks
  name = var.name
  env = var.env
  location = var.location
  system_node_count = var.system_node_count
  kubernetes_version = var.kubernetes_version
  purpose = var.purpose
  aks_dns_service_ip  = var.aks_dns_service_ip
  aks_service_cidr  = var.aks_service_cidr
  subnet_aks_id = module.subnet.snt_id_out.snet04
  app_gw_id = module.appgateway.agw_id_out
  client_id = var.client_id
  client_secret = var.client_secret
  depends_on = [module.appgateway]
  resource_group_name = module.resource_group.rg_name_out.rg02
  aks_resource_group_name = var.aks_resource_group_name
  log_analytics_workspace_id = module.loganalyticsworkspace.log_analytics_out_id.lgw01
  #namespace_name = var.namespace_name
  aks_spn_objectid = var.aks_spn_objectid
  acr_id = module.acr.acr_id_out
  solution_stg_id = module.storage_account.stg_account_out_id.stg02
  aks_identity_name = var.aks_identity_name
  keyvault_id = module.key_vault.key_vault_out_id.kv02
  tags  = var.tags
}

#ACR Configuration
module "acr" {
  source = "./ACR"
  name = var.name
  env = var.env
  location = var.location
  purpose = var.purpose
  resource_group_name = module.resource_group.rg_name_out.rg02
  subnet_id = module.subnet.snt_id_out.snet04
  tags  = var.tags
}

# Redis Cache Configuration
module "cacheforredis" {
  source = "./CacheforRedis"
  name = var.name
  env = var.env
  location = var.location
  purpose = var.purpose
  resource_group_name = module.resource_group.rg_name_out.rg02
  redis_sku_name =  var.redis_sku_name
  family = var.family
  subnet_id = module.subnet.snt_id_out.snet05
  nw_resource_group_name = module.resource_group.rg_name_out.rg03
  app_subnet_id = module.subnet.snt_id_out.snet05
  virtual_network_id = module.virtual_network.vnet_id_out
  depends_on = [module.aks]
  tags  = var.tags
}


#Postgresql Configuration
module "postgresql" {
  source = "./postgresql"
  postgresql = var.postgresql
  name = var.name
  env = var.env
  resource_group_name = module.resource_group.rg_name_out.rg02
  nw_resource_group_name = module.resource_group.rg_name_out.rg03
  virtual_network_id = module.virtual_network.vnet_id_out
  subnet_db_id = module.subnet.snt_id_out.snet02
  depends_on = [module.aks]
  tags  = var.tags
}

# CognitiveServices Configuration

module "cognitiveservices" {
  source = "./CognitiveServices"
  name = var.name
  env = var.env
  location = var.location
  purpose = var.purpose
  resource_group_name = module.resource_group.rg_name_out.rg02
  cgs_sku = var.cgs_sku
  custom_subdomain_name = var.custom_subdomain_name
  #subnet_id = module.subnet.snt_id_out.snet01
  nw_resource_group_name = module.resource_group.rg_name_out.rg03
  app_subnet_id = module.subnet.snt_id_out.snet05
  virtual_network_id = module.virtual_network.vnet_id_out
  depends_on = [module.postgresql]
  tags  = var.tags
}

# OpenAI Configuration

module "OpenAI" {
  source = "./openaiservices"
  name = var.name
  env = var.env
  location = var.location
  purpose = var.purpose
  resource_group_name = module.resource_group.rg_name_out.rg02
  oai_sku = var.oai_sku
  oai_custom_subdomain_name = var.oai_custom_subdomain_name
  #subnet_id = module.subnet.snt_id_out.snet01
  nw_resource_group_name = module.resource_group.rg_name_out.rg03
  app_subnet_id = module.subnet.snt_id_out.snet05
  virtual_network_id = module.virtual_network.vnet_id_out
  depends_on = [module.postgresql]
  tags  = var.tags
}

