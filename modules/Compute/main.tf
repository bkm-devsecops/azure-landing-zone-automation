# resource "azurerm_network_interface" "nic" {
#     for_each = var.nic
#     name =each.value.name
#     location =each.value.location
#     resource_group_name =each.value.resource_group_name
#  ip_configuration {
#     name                          = "internal"
#     subnet_id                     = var.subnet_id[each.value.subnet_key]
#     private_ip_address_allocation = "Dynamic"
#   }
 # depends_on = [ azurerm_subnet.subnetwork ]
resource "azurerm_network_interface" "nic" {
  for_each            = var.nic
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    
    # Bilkul sahi andaz me lookup:
    subnet_id                     = lookup(var.subnet_id, each.value.subnet_key, null)
  }
}
resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vms
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    admin_username                  = each.value.admin_username
     admin_password                  = "SecurePassword@1234" #
  size                = "Standard_D2a_v4"
  disable_password_authentication = false
#   admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic[each.value.nic_key].id]
  

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  depends_on = [azurerm_network_interface.nic ]
}
