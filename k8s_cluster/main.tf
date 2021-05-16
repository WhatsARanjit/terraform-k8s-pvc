provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "${var.prefix}-rg"
  location = "West US 2"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    kube_dashboard {
      enabled = false
    }
  }

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_key_vault_secret" "k8s_certificate" {
  name         = "k8s-certificate"
  value        = azurerm_kubernetes_cluster.default.kube_config.0.client_certificate
  key_vault_id = azurerm_key_vault.k8s_auth.id
}

resource "azurerm_key_vault_secret" "k8s_key" {
  name         = "k8s-key"
  value        = azurerm_kubernetes_cluster.default.kube_config.0.client_key
  key_vault_id = azurerm_key_vault.k8s_auth.id
}

resource "azurerm_key_vault_secret" "k8s_ca_certificate" {
  name         = "k8s-ca-certificate"
  value        = azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate
  key_vault_id = azurerm_key_vault.k8s_auth.id
}
