module "resource_groups" {
  source = "./modules/resource_groups"
  rgs    = var.rgs
}
module "networking" {
  source  = "./modules/Network_group"
  vnets   = var.vnets
  subnets = var.subnets
  nsgs    = var.nsgs

  depends_on = [module.resource_groups]
}
module "compute" {
  source = "./modules/Compute"
  nic    = var.nic # 👈 CHECK 1: Left side par 'nics' hona chahiye kyuki child variables.tf mein 'nics' declare hai
  vms    = var.vms
  subnet_id           = module.networking.subnet_ids
  #   subnet_mapping = module.networking.subnet_ids # 👈 CHECK 2: 'subnet_ids' (plural) aur module name lowercase mein match ho gaya
  depends_on = [module.networking]
}