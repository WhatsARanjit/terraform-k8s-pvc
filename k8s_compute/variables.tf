variable "volume_name" {
  default = "my-volume"
}

variable "organization" {
  description = "Name of current TF organization"
  default     = "ranjit-org"
}

variable "k8s_cluster_workspace" {
  description = "Name of workspace where the k8s cluster is deployed"
  default     = "k8s-cluster"
}

variable "k8s_pvc_workspace" {
  description = "Name of workspace where the k8s pvc is deployed"
  default     = "k8s-pvc"
}
