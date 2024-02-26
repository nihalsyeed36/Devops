# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.71.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true
  features {}

  subscription_id = "190bc9e2-3b22-47f2-9bc6-33de890fdcc3"
  client_id       = "1c9230ae-6f60-461e-964e-723ce90cd291"
  client_secret   = "1Zn8Q~4yx-w1gNfUhdvD_.SgvGXxBfXg6Q7~EbUF"
  tenant_id       = "0ae51e19-07c8-4e4b-bb6d-648ee58410f4"
}

# Backend configuration

terraform {
  backend "azurerm" {
    resource_group_name   = "acona-dev-tfm-we-rgp"
    storage_account_name  = "aconadevtfmwestg"
    container_name        = "terraform"
    key                   = "aconadevinfra.tfstate"
    access_key = "vmkG9a2Mk/De2rStEQrSZGS0J4XJAfCDkBUtlGqqgDTgVnwkjF+DyrTRiQ8iWZVdmhU+9cOa3hIC+ASttC5ojQ=="
  }
}
