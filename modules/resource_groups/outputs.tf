output "rg_outputs" {
  description = "Outputs from resource group module"
  value       = { for k, v in azurerm_resource_group.rg : k => { name = v.name, location = v.location } }
}