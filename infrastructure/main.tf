terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.80"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>1.13"
    }
  }
  # Use Azure storage container to hold terrafrom state. Using local, as I don't want this to be a dependency. 
  backend "local" {
    path = "${path.module}/terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.azure.subscription_id
  tenant_id       = var.azure.tenant_id
  features {}
}

provider "kubernetes" {
  load_config_file = "false"
  host             = azurerm_kubernetes_cluster.k8s.kube_config.0.host

  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
}

locals {
  common_resource_name = var.resource_prefix
  resource_group_name  = local.common_resource_name
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.resource_group_name
  location = var.azure.location
  tags     = var.tags
}
