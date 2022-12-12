output "webapp_host" {
  description = "hostname for the website"
  value       = azurerm_linux_web_app.webapp.default_hostname
}

output "webapp_id" {
  description = "id of the web app created"
  value       = azurerm_linux_web_app.webapp.id
}

output "webapp_url" {
  description = "url of the web app created"
  value       = "https://${azurerm_linux_web_app.webapp.name}.azurewebsites.net"
  # value       = azurerm_linux_web_app.webapp.url
}
