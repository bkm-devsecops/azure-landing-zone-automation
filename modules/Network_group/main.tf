resource "azurerm_virtual_network" "Virtual_network" {
    for_each =var.vnets
    name =each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    address_space = each.value.address_space
    
}
resource "azurerm_subnet" "subnetwork" {
    for_each = var.subnets
    name =each.value.name
    virtual_network_name = each.value.virtual_network_name
    address_prefixes = each.value.address_prefixes
    resource_group_name = each.value.resource_group_name
    depends_on = [ azurerm_virtual_network.Virtual_network ]
  
}
resource "azurerm_network_security_group" "nsg" {
    for_each =var.nsgs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  depends_on = [ azurerm_subnet.subnetwork ]

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  # 1. 🟢 loop lagana zaroori hai tabhi each.key chalega
  # 2. 🔐 Bastion subnet ko filter out (skip) karne ka logic
  for_each = {
    for k, v in var.subnets : k => v 
    if v.name != "AzureBastionSubnet"
  }

  subnet_id = azurerm_subnet.subnetwork[each.key].id
  
  # Conditional check: Agar resource group srushti hai toh nsg1, nahi toh nsg2
  network_security_group_id = each.value.resource_group_name == "dev" ? azurerm_network_security_group.nsg["nsg1"].id : azurerm_network_security_group.nsg["nsg2"].id
}
# resource "azurerm_network_interface" "nics" {
#     for_each = var.nic
#   name                = "each.value.name"
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnetwork[each.key].id
#     private_ip_address_allocation = "Dynamic"
#   }
#   depends_on = [ azurerm_subnet.subnetwork ]
# }