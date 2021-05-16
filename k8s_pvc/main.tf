resource "azurerm_managed_disk" "example" {
  name                 = "${var.tier}-example"
  location             = data.terraform_remote_state.aks.outputs.resource_group_location
  resource_group_name  = data.terraform_remote_state.aks.outputs.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"
  tags = {
    environment = data.terraform_remote_state.aks.outputs.resource_group_name
  }
}

resource "kubernetes_persistent_volume" "my_storage_class" {
  metadata {
    name = "${var.tier}-storage-class"
  }
  spec {
    capacity = {
      storage = "${var.pvc_size}Gi"
    }
    storage_class_name = "default"
    access_modes       = ["ReadWriteOnce"]
    persistent_volume_source {
      azure_disk {
        caching_mode  = "None"
        data_disk_uri = azurerm_managed_disk.example.id
        disk_name     = "example"
        kind          = "Managed"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "my_pod_storage" {
  metadata {
    name = "${var.tier}-pod-storage"
  }
  spec {
    storage_class_name = "default"
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.my_storage_class.metadata.0.name
  }
}
