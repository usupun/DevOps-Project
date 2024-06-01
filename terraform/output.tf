output "cluster_name" {
    value = google_container_cluster.default.name
}
output "cluster_endpoint" {
    value = google_container_cluster.default.endpoint
}
output "cluster_location" {
    value = google_container_cluster.default.location
}
output "load_balancer_ip" {
    value = googel_compute_address.default.address
}