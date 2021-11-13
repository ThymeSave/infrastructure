output "instance_ids" {
  value       = oci_core_instance.node.*.id
  description = "IDs of the created vm instances"
}

output "instance_ips" {
  value       = oci_core_instance.node.*.private_ip
  description = "IPs of the created vm instances"
}
