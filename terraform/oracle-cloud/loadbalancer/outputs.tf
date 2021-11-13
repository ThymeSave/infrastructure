output "loadbalancer_ips" {
  value       = oci_load_balancer.this.ip_addresses
  description = "IPs for the created load balancer"
}
