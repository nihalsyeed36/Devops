
# RG
resource_groups = {
    rg01 = { 
        location = "West Europe"
        purpose ="infra"
    },   
    rg02 = { 
        location = "West Europe"
        purpose ="solution"
    }, 
    rg03 = { 
        location = "West Europe"
        purpose ="network"
    }
}
env = "dev"

name = "acona"


#Keyvault
key_vault = {
   "kv01" = {
        location = "West Europe"
        purpose ="infra"
        purge_protection_enabled = true
        sku_name                         = "standard"
        resource_group_name = "acona-dev-infra-we-rgp"
    },
    "kv02"  = {
        location = "West Europe"
        purpose ="solution"
        purge_protection_enabled = true
        sku_name                         = "standard"
        resource_group_name = "acona-dev-solution-we-rgp"
    },
}

#Keyvault secrets
#key_vault_secret = {
#  "kv_sec01" = {
#      secret_name="postgres-password"
#      secret_value = "string"
#  }
#}

#Storageaccount
storage_account = {
    "stg01" = {
        location = "West Europe"
        purpose ="infra"
        account_kind              = "StorageV2"
        account_tier              = "Standard" 
        account_replication_type  = "LRS"
        min_tls_version           = "TLS1_2"
        enable_https_traffic_only = "true"
        resource_group_name = "acona-dev-infra-we-rgp"

  },
    "stg02" = {
        location = "West Europe"
        purpose ="solution"
        account_kind              = "BlockBlobStorage"
        account_tier              = "Premium"
        account_replication_type  = "LRS"
        min_tls_version           = "TLS1_2"
        enable_https_traffic_only = "true" 
        resource_group_name = "acona-dev-solution-we-rgp"
  }
}

#VNET
virtual_network = {
   "vnet" = {
    }
}

virtual_network_address_space   = ["10.0.0.0/16"]
virtual_network_location    = "West Europe"

#SNET
subnet = {
  "snet01" = {
        location = "West Europe"
        purpose ="network"
        num = "infra"
        address_prefixes = ["10.0.1.0/24"]
        service_endpoints   =  ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.CognitiveServices"]
  },
  "snet02" = {
        location = "West Europe"
        purpose ="network"
        num = "db"
        address_prefixes = ["10.0.2.0/24"]
        service_endpoints   =  ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.CognitiveServices"]
  },
  "snet03" = {
        location = "West Europe"
        purpose ="network"
        num = "appgw"
        address_prefixes = ["10.0.3.0/24"]
        service_endpoints   =  ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.CognitiveServices"]
  },
  "snet04" = {
        location = "West Europe"
        purpose ="network"
        num = "aks"
        address_prefixes = ["10.0.4.0/22"]
        service_endpoints   =  ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.CognitiveServices", "Microsoft.ContainerRegistry"]
  },
  "snet05" = {
        location = "West Europe"
        purpose ="network"
        num = "app"
        address_prefixes = ["10.0.8.0/24"]
        service_endpoints   =  ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.CognitiveServices"]
  }
}

#NSG
network_security_group = {
  "nsg01" = {
        location = "West Europe"
        purpose ="network"
        num = "infra"
  },
  "nsg02" = {
        location = "West Europe"
        purpose ="network"
        num = "db"
  },
  "nsg03" = {
        location = "West Europe"
        purpose ="network"
        num = "appgw"
  },
  "nsg05" = {
        location = "West Europe"
        purpose ="network"
        num = "app"
  }
}

# LGW 
log_analytics_workspace = {
  "lgw01" = {
      location = "West Europe"
      purpose ="infra"
  }
}

#AKS
aks = {
  "aks01" = {
  }
}

location = "West Europe"
purpose ="solution"
kubernetes_version  = "1.26.6"
system_node_count   = "1"
aks_dns_service_ip  = "10.1.0.10"
aks_service_cidr  = "10.1.0.0/16"
aks_resource_group_name = "nav-tst-aks-we-rgp"

client_id = "97fc9c8d-458a-4ba3-81ee-a3a27fc54423"
client_secret = "B~68Q~KawvSiE9o2xoqRH7jb7~6Hbn2Py~DsCaft"
aks_spn_objectid  = "a14a62fd-4636-45ff-900b-8192de6fa3c8"

aks_identity_name = "aks-identity"
#namespace_name = "acona"

#Postgresql
postgresql={
    pqldb01={
  
 location = "West Europe"
 purpose="solution"
 num=1 
 administrator_login          ="psqladmin"
  administrator_password="QmX3fpQblgKLIwihw9Vd"
  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768
  version    = "14"

  backup_retention_days         = 7
  geo_redundant_backup_enabled  = "false"
    },
}


#AppGW
appgw_sku_name="WAF_v2"
appgw_sku_tier="WAF_v2"
appgw_capacity=1


#Redis cache
redis_sku_name  = "Basic"
family  = "C"

#CGS
cgs_sku = "S0"
custom_subdomain_name = "acona-dev-we-cognitiveservices"

#OAI
oai_sku = "S0"
oai_custom_subdomain_name = "acona-dev-we-apenaiservices"

#Tags
tags  = {
env= "dev"
createdby = "terraform"
createdon = "30th-aug-2023"
project = "acona"
businessowner = ""
}