output "instance_ids" {
  value = oci_core_instance.node.*.id
  description = "IDs of the created vm instances"
}
