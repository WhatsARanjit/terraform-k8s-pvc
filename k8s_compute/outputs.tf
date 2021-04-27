output "deployment_name" {
  value = kubernetes_deployment.my_app_deployment.metadata.0.name
}
