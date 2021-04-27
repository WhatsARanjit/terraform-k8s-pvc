terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.50.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.0.3"
    }
  }
}
