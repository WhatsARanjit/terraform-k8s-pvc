output "kubernetes_pvc_name" {
  value = kubernetes_persistent_volume_claim.my_pod_storage.metadata[0].name
}
