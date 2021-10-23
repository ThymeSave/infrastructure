resource "oci_core_subnet" "bastion" {
  availability_domain = data.oci_identity_availability_domains.this.availability_domains[0].name
  cidr_block          = local.bastion_cidr
  display_name        = "bastion"
  dns_label           = "bastion"
  security_list_ids   = [oci_core_vcn.thymesave.default_security_list_id]
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.thymesave.id
  route_table_id      = oci_core_vcn.thymesave.default_route_table_id
  dhcp_options_id     = oci_core_vcn.thymesave.default_dhcp_options_id
}
