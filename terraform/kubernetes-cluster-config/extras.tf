resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.7.7"
  namespace        = "argocd"
  create_namespace = true
  set {
    name  = "server.service.type"
    value = "NodePort"
  }
}

data "kubernetes_secret" "argocd_server_secret" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
  depends_on = [helm_release.argocd]
}