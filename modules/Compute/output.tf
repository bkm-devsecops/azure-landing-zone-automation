# 1. Saari VMs ki Private IP Addresses ka Map
output "vm_private_ips" {
  description = "Created Virtual Machines ki Private IP addresses ki list"
  value       = { for k, v in azurerm_network_interface.nic : k => v.private_ip_address }
}

# 2. Saari VMs ki Unique Resource IDs ka Map
output "vm_ids" {
  description = "Created Virtual Machines ki Azure Resource IDs"
  value       = { for k, v in azurerm_linux_virtual_machine.vm : k => v.id }
}

# 3. Network Interfaces (NIC) ki IDs ka Map
output "nic_ids" {
  description = "Created Network Interfaces ki Resource IDs"
  value       = { for k, v in azurerm_network_interface.nic : k => v.id }
}