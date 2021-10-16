output "vnc_id" {
  value       = oci_core_vcn.thymesave.id
  description = "Id of the created VNC"
}

output "vcn_cidr" {
  value       = local.vcn_cidr
  description = "CIDR of the created VCN"
}

output "subnet_private_cidr" {
  value       = local.subnet_private_cidr
  description = "CIDR of the private subnet"
}

output "subnet_private_id" {
  value       = oci_core_subnet.private.id
  description = "ID of the private subnet"
}

output "subnet_public_cidr" {
  value       = local.subnet_public_cidr
  description = "CIDR of the public subnet"
}

output "subnet_public_id" {
  value       = oci_core_subnet.public.id
  description = "ID of the public subnet"
}
