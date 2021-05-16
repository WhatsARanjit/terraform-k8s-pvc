variable "organization" {
  description = "Name of current TF organization"
  default     = "ranjit-org"
}

variable "k8s_cluster_workspace" {
  description = "Name of workspace where the k8s cluster is deployed"
  default     = "k8s-cluster"
}

variable "pvc_size" {
  description = "Size of volume in Gi"
  default     = "5"
}
