#Variables for names
variable "rgName" {
  type = string
}

variable "vnetName" {
  type = string
}

variable "gatewayName" {
  type = string
}

#Variables for CIDRs
variable "vnetCidr" {
  type = string
}

variable "gatewayCidr" {
  type = string
}

variable "bastionCidr" {
  type = string
}

variable "hubtospoke1" {
  type = string
}

variable "hubtospoke1id" {
  type = string
}

variable "hubtospoke2" {
  type = string
}

variable "hubtospoke2id" {
  type = string
}


#Resource Group
resource "azurerm_resource_group" "hubgroup" {
  //provider            = "azurerm.connectivity"
  name     = var.rgName
  location = "West Europe"
}

#Virtual Network
resource "azurerm_virtual_network" "hub" {
  //provider            = "azurerm.connectivity"
  name                = var.vnetName
  location            = azurerm_resource_group.hubgroup.location
  resource_group_name = azurerm_resource_group.hubgroup.name
  address_space       = [var.vnetCidr]

#Subnets
  subnet {
    name           = var.gatewayName
    address_prefix = var.gatewayCidr
  }

  subnet {
    name           = "AzureBastionSubnet"
    address_prefix = var.bastionCidr
  }
}

resource "azurerm_virtual_network_peering" "hubtosharedprod" {
  name                      = var.hubtospoke1
  resource_group_name       = azurerm_resource_group.hubgroup.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = var.hubtospoke1id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "hubtomanagement" {
  name                      = var.hubtospoke2
  resource_group_name       = azurerm_resource_group.hubgroup.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = var.hubtospoke2id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
}


output "hubid" {
  value = azurerm_virtual_network.hub.id
}


