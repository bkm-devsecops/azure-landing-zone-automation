# 1. Backend storage ke liye ek dedicated Resource Group (Agar pehle se nahi hai)
resource "azurerm_resource_group" "tf_backend_rg" {
  name     = "tf-state-backend-rg"
  location = "East US" # Ya jo bhi aapki pasandida location ho
}

# 2. Unique Storage Account (Naam unique hona chahiye globally)
resource "azurerm_storage_account" "tf_backend_sa" {
  name                     = "brijendratfstate2026" # Is naam ko thoda badal sakte hain unique rakhne ke liye
  resource_group_name      = azurerm_resource_group.tf_backend_rg.name
  location                 = azurerm_resource_group.tf_backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  blob_properties {
    versioning_enabled = true # Taaki state file ki history safe rahe
  }
}

# 3. Blob Container jahan actually terraform.tfstate file baithegi
resource "azurerm_storage_container" "tf_backend_container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tf_backend_sa.id
  container_access_type = "private"
}