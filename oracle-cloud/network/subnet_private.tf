resource "oci_core_subnet" "private" {
  count               = length(local.private_subnets)
  availability_domain = data.oci_identity_availability_domains.this.availability_domains[count.index].name
  cidr_block          = local.private_subnets[count.index]
  display_name        = "private${count.index + 1}"
  dns_label           = "private${count.index + 1}"
  security_list_ids   = [oci_core_security_list.private.id]
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.thymesave.id
  route_table_id      = oci_core_vcn.thymesave.default_route_table_id
  dhcp_options_id     = oci_core_vcn.thymesave.default_dhcp_options_id
}

resource "oci_core_security_list" "private" {
  display_name   = "Security List for private subnets"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.thymesave.id

  // allow outgoing traffic
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  // allow ping
  ingress_security_rules {
    source   = local.private_cidr
    protocol = "1"

    icmp_options {
      type = 3
    }
  }

  // allow ssh from bastion hosts
  ingress_security_rules {
    source   = local.bastion_cidr
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }
}
