resource "oci_core_subnet" "private" {
  availability_domain = data.oci_identity_availability_domain.ad2.name
  cidr_block          = local.subnet_private_cidr
  display_name        = "private"
  dns_label           = "private"
  security_list_ids   = [oci_core_security_list.private.id]
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.thymesave.id
  route_table_id      = oci_core_vcn.thymesave.default_route_table_id
  dhcp_options_id     = oci_core_vcn.thymesave.default_dhcp_options_id
}

resource "oci_core_security_list" "private" {
  display_name   = "Security List for private subnet"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.thymesave.id

  // allow outgoing traffic
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  // allow ping
  ingress_security_rules {
    source   = local.subnet_private_cidr
    protocol = "1"

    icmp_options {
      type = 3
    }
  }

  // allow ssh from bastion hosts
  ingress_security_rules {
    source   = local.subnet_private_cidr
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }
}
