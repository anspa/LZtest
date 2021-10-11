# Modules

# Hub network
module "vnet-hubnetwork-connectivity-we-001" {
  source = "./vnet-hubnetwork-connectivity-we-001"
# Names
  rgName = "rg-hubnetwork-connectivity-we-001"
  vnetName = "vnet-hubnetwork-connectivity-we-001"
  gatewayName = "snet-gateway-connectivity-we-001"
  hubtospoke1 = "vnet-hub-vnet-sharedprod-prod-we-001"
  hubtospoke1id = module.vnet-sharedprod-prod-we-001.spokeid
  hubtospoke2 = "vnet-hub-vnet-management-mgmt-we-001"
  hubtospoke2id = module.vnet-management-mgmt-we-001.spokeid 
  /*providers = {
    azurerm = azurerm.connectivity
  }
  */

# CIDRs
  vnetCidr = "10.20.0.0/16"
  gatewayCidr = "10.20.254.0/24"
  bastionCidr = "10.20.253.0/27"

}

#Shared prod
module "vnet-sharedprod-prod-we-001" {
  source = "./vnet-sharedprod-prod-we-001"
  #Names
  rgName = "rg-vnet-sharedprod-prod-we-001"
  vnetName = "vnet-sharedprod-prod-we-001"
  subscription = "azurerm.sharedprod"
  spoke-to-hub = "vnet-sharedprod-prod-we-001-vnet-hub"
  hubid = module.vnet-hubnetwork-connectivity-we-001.hubid
  #Subscription
  /*providers = {
    azurerm = azurerm.sharedprod
  }
  */

#CIDRs
  vnetCidr = "10.21.0.0/16"
  reserved1Cidr = "10.21.254.0/24"
  reserved2Cidr = "10.21.253.0/24"
  reserved3Cidr = "10.21.252.0/24"
}


#Management
module "vnet-management-mgmt-we-001" {
  source = "./vnet-management-mgmt-we-001"
  #Names
  rgName = "rg-vnet-management-mgmt-we-001"
  vnetName = "vnet-management-mgmt-we-001"
  subscription = "azurerm.sharedprod"
  spoke-to-hub = "vnet-management-mgmt-we-001-vnet-hub"
  hubid = module.vnet-hubnetwork-connectivity-we-001.hubid
  #Subscription
  /*providers = {
    azurerm = azurerm.management
  }
  */

#CIDRs
  vnetCidr = "10.22.0.0/16"
  reserved1Cidr = "10.22.254.0/24"
  reserved2Cidr = "10.22.253.0/24"
  reserved3Cidr = "10.22.252.0/24"
}