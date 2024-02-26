#data "azuread_client_config" "current" {}

resource "azuread_application" "tf-spn" {
  display_name = "${var.name}-${var.env}-aks-we-spn"
  #owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "tf-spn" {
  application_id               = azuread_application.tf-spn.application_id
  app_role_assignment_required = true
  #owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "tf-spn" {
  service_principal_id = azuread_service_principal.tf-spn.object_id
}