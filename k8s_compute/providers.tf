# Source pvc workspace
data "terraform_remote_state" "pvc" {
  backend = "remote"

  config = {
    organization = var.organization
    workspaces   = {
      name = var.k8s_pvc_workspace
    }
  }
}

# Source cluster workspace
data "terraform_remote_state" "aks" {
  backend = "remote"

  config = {
    organization = var.organization
    workspaces   = {
      name = var.k8s_cluster_workspace
    }
  }
}

# Retrieve AKS cluster information
provider "azurerm" {
  features {}
}

data "azurerm_key_vault_secret" "k8s_certificate" {
  name         = "k8s-certificate"
  key_vault_id = data.terraform_remote_state.aks.outputs.k8s_key_vault_id
}

data "azurerm_key_vault_secret" "k8s_key" {
  name         = "k8s-key"
  key_vault_id = data.terraform_remote_state.aks.outputs.k8s_key_vault_id
}

data "azurerm_key_vault_secret" "k8s_ca_certificate" {
  name         = "k8s-ca-certificate"
  key_vault_id = data.terraform_remote_state.aks.outputs.k8s_key_vault_id
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.aks.outputs.k8s_host
  client_certificate     = base64decode(data.azurerm_key_vault_secret.k8s_certificate.value)
  client_key             = base64decode(data.azurerm_key_vault_secret.k8s_key.value)
  cluster_ca_certificate = base64decode(data.azurerm_key_vault_secret.k8s_ca_certificate.value)
}
