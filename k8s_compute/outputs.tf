output "deployment_uid" {
  value = kubernetes_deployment.my_app_deployment.metadata.0.name
}
