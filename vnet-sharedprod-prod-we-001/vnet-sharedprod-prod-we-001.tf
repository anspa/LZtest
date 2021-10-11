#Variables
variable "subscription" {
  type = string
}

variable "rgName" {
  type = string
}

variable "vnetName" {
  type = string
}

variable "vnetCidr" {
  type = string
}

variable "reserved1Cidr" {
  type = string
}

variable "reserved2Cidr" {
  type = string
}

variable "reserved3Cidr" {
  type = string
}

variable "spoke-to-hub" {
  type = string
}

variable "hubid" {
  type = string
}

#Hubnetwork Data
/*data "azurerm_virtual_network" "hub_network" {
  name = "vnet-hubnetwork-connectivity-we-001"
  resource_group_name = "rg-vnet-hubnetwork-connectivity-we-001"
}*/

#Resource Group
resource "azurerm_resource_group" "spokegroup" {
  name     = var.rgName
  location = "West Europe"
  //provider = azurerm.sharedprod
}

#Virtual Network
resource "azurerm_virtual_network" "spoke" {
  name                = var.vnetName
  location            = azurerm_resource_group.spokegroup.location
  resource_group_name = azurerm_resource_group.spokegroup.name
  address_space       = [var.vnetCidr]
  //provider = azurerm.sharedprod


#Subnets
  subnet {
    name           = "snet-reserved1"
    address_prefix = var.reserved1Cidr
  }

  subnet {
    name           = "snet-reserved2"
    address_prefix =  var.reserved2Cidr
  }

  subnet {
    name           = "snet-reserved3"
    address_prefix =  var.reserved3Cidr
  }
}

resource "azurerm_virtual_network_peering" "spoketohub" {
  name                      = var.spoke-to-hub
  resource_group_name       = azurerm_resource_group.spokegroup.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = var.hubid
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
}

output "spokeid" {
  value = azurerm_virtual_network.spoke.id
}
