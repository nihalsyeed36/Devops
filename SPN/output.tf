output "service_principal_name" {
  description = "The object id of service principal. Can be used to assign roles to user."
  value       = azuread_service_principal.tf-spn.display_name
}

output "service_principal_object_id" {
  description = "The object id of service principal. Can be used to assign roles to user."
  value       = azuread_service_principal.tf-spn.object_id
}

output "service_principal_tenant_id" {
  value = azuread_service_principal.tf-spn.application_tenant_id
}

output "service_principal_application_id" {
  description = "The object id of service principal. Can be used to assign roles to user."
  value       = azuread_service_principal.tf-spn.application_id
}

output "client_id" {
  description = "The application id of AzureAD application created."
  value       = azuread_application.tf-spn.application_id
}

output "client_secret" {
  description = "Password for service principal."
  value       = azuread_service_principal_password.tf-spn.value
 
}