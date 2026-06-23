output "subnet_ids" {
  description = "Map of subnet keys to subnet IDs"
  value       = { for k, v in azurerm_subnet.subnetwork : k => v.id }
}