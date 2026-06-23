# Resource Group Module se output khinch kar terminal par dikhane ke liye
output "rg_outputs" {
  description = "Outputs from resource group module"
  value       = module.resource_groups.rg_outputs
}

# Network Module se Subnet IDs khinch kar terminal par dikhane ke liye
output "root_subnet_ids" {
  description = "Subnet IDs deployed via networking module"
  value       = module.networking.subnet_ids # ◄ Child module ka output variable name
}