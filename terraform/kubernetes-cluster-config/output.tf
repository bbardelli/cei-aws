output "argo_server_secret" {
  value     = data.kubernetes_secret.argocd_server_secret.data["password"]
  sensitive = true
}