resource "kubernetes_deployment" "name" {
    metadata {
        name = "node-app-deployment"
    }
    spec {
        replicas = 1
        selector {
            match_labels = {
                "app" = "node-app"
            }
        }
        template {
            metadata {
                labels = {
                    "app" = "node-app"
                }
            }
            spec {
                container {
                    name = "node-app"
                    image = var.container_image
                    port {
                        container_port = 3000
                    }
                }
            }
        }
    }
}

# First, we need to define the compute address
resource "google_compute_address" "default" {
    name   = "ipforservice"
    region = var.region
}

# Add main resource
resource "kubernetes_service" "appservice" {
    metadata {
        name = "node-app-service"
    }
    spec {
        type            = "LoadBalancer"
        load_balancer_ip = google_compute_address.default.address
        port {
            protocol    = "TCP"
            port        = 80
            target_port = 3000
        }
    }
}
