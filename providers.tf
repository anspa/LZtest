terraform {
  backend "azurerm" {
    resource_group_name   = "rg-anspa-tf-mgmt-we-001"
    storage_account_name  = "anspasttfmgmtwe001"
    container_name        = "terraformnetworkstate"
    key                   = "terraform.terraformnetworkstate"
  }
}

provider "azurerm" { 
  features {}
}

/*provider "azurerm" {
  alias           = "connectivity"
  subscription_id = "0795d9cc-0225-4daa-a0ff-ac2cc234084b"
  features {}
}

provider "azurerm" {
  alias           = "sharedprod"
  subscription_id = "7c232480-1807-4cbf-8a46-625313cb48fc"
  features {}
}

provider "azurerm" {
  alias           = "management"
  subscription_id = "0cd57938-a2c2-4ffd-ad3c-ba046c76323b"
  features {}
}
*/