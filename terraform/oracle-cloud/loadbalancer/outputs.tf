output "loadbalancer_ips" {
  value       = oci_network_load_balancer_network_load_balancer.this.ip_addresses
  description = "IPs for the created load balancer"
}
