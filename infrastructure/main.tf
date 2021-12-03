terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.80"
    }
  }
  # Use Azure storage container to hold terrafrom state for better experience. Using local, as I don't want this to be a dependency. 
  backend "local" {
    path = "${path.module}/terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.azure.subscription_id
  tenant_id       = var.azure.tenant_id
  features {}
}
