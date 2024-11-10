output "be_container_app_fqdn" {
  value       = azurerm_container_app.backend_container_app.latest_revision_fqdn
  description = "The FQDN of the backend container app"
}

output "be_fn_container_app_fqdn" {
  value       = azurerm_container_app.backend_function_container_app.latest_revision_fqdn
  description = "The FQDN of the backend function container app"
}

output "fe_fn_container_app_fqdn" {
  value       = azurerm_container_app.frontend_function_container_app.latest_revision_fqdn
  description = "The FQDN of the backend function container app"
}


output "fe_container_app_fqdn" {
  value       = azurerm_container_app.frontend_container_app.latest_revision_fqdn
  description = "The FQDN of the frontend container app"
}
