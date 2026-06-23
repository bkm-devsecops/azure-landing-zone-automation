rgs = {
  rg1 = {
    name     = "dev"
    location = "centralindia"
  }
  rg2 = {
    name     = "qa"
    location = "southindia"
  }
}

vnets = {
  vnet1 = {
    name                = "dev-vnet"
    location            = "centralindia"
    address_space       = ["10.0.0.0/16"]
    resource_group_name = "dev"
    dns_server          = ["10.0.0.4", "10.0.0.5"]

  }

}
subnets = {
  subnet1 = {
    name                 = "dev-subnet1"
    resource_group_name  = "dev"
    virtual_network_name = "dev-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "azure-bastion-subnet1"
    resource_group_name  = "dev"
    virtual_network_name = "dev-vnet"
    # location = "centralindia"
    address_prefixes = ["10.0.10.0/26"]
  }
}
nsgs = {
  nsg1 = {
    name                = "dev-security-group1"
    location            = " centralindia"
    resource_group_name = "dev"
  }
}
nic = {
  nic1 = {
    name                = "dev-nic1"
    location            = "centralindia"
    resource_group_name = "dev"
    subnet_key          = "subnet1"

  }
  nic2 = {
    name                = "dev-nic2"
    location            = "centralindia"
    resource_group_name = "dev"
    subnet_key          = "subnet2"
  }
}
vms = {
  vm1 = {
    name                = "dev-machine1"
    resource_group_name = "dev"
    location            = "centralindia"
    size                = "Standard_D4_v5"
    admin_username      = "adminuser"
    nic_key             = "nic1"
  }
  vm2 = {
    name                = "dev-machine2"
    resource_group_name = "dev"
    location            = "centralindia"
    size                = "Standard_D4_v5"
    admin_username      = "adminuser"
    nic_key             = "nic2"
  }
}