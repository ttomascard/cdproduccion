output "be_container_app_fqdn" {
  value       = azurerm_container_app.backend_container_app.latest_revision_fqdn
  description = "The FQDN of the backend container app"
}

output "fe_container_app_fqdn" {
  value       = azurerm_container_app.frontend_container_app.latest_revision_fqdn
  description = "The FQDN of the frontend container app"
}
