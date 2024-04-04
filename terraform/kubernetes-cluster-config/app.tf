resource "kubernetes_deployment" "exam-server" {
  metadata {
    name = "exam-server"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "exam-server"
      }
    }
    template {
      metadata {
        labels = {
          app = "exam-server"
        }
      }
      spec {
        image_pull_secrets {
          name = "docker-registry"
        }
        init_container {
          image = "885903886121.dkr.ecr.eu-south-2.amazonaws.com/cei-exam-test"
          name  = "exam-server-init"
          env {
            name  = "REDIS_HOST"
            value = "exam-redis"
          }
          env {
            name  = "DATABASE_TYPE"
            value = "redis"
          }
          command = ["python", "export-to-redis.py"]
        }
        container {
          image = "885903886121.dkr.ecr.eu-south-2.amazonaws.com/cei-exam-test"
          name  = "exam-server"
          env {
            name  = "REDIS_HOST"
            value = "exam-redis"
          }
          env {
            name  = "DATABASE_TYPE"
            value = "redis"
          }
          port {
            container_port = 80
          }
        }
      }
    }
  }

}

resource "kubernetes_service" "exam-server" {
  metadata {
    name = "exam-server"
  }
  spec {
    selector = {
      app = kubernetes_deployment.exam-server.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 80
      node_port   = 30001
    }
    type = "NodePort"
  }

}

resource "kubernetes_deployment" "exam-redis" {
  metadata {
    name = "exam-redis"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "exam-redis"
      }
    }
    template {
      metadata {
        labels = {
          app = "exam-redis"
        }
      }
      spec {
        container {
          image = "redis"
          name  = "redis"
          port {
            container_port = 6379
          }
        }
      }
    }
  }

}

resource "kubernetes_service" "exam-redis" {
  metadata {
    name = "exam-redis"
  }
  spec {
    selector = {
      app = kubernetes_deployment.exam-redis.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 6379
      target_port = 6379
    }
    type = "ClusterIP"
  }

}