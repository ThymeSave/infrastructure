resource "oci_core_subnet" "public" {
  availability_domain = data.oci_identity_availability_domain.ad2.name
  cidr_block          = local.subnet_public_cidr
  display_name        = "public"
  dns_label           = "public"
  security_list_ids   = [oci_core_security_list.public.id]
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.thymesave.id
  route_table_id      = oci_core_vcn.thymesave.default_route_table_id
  dhcp_options_id     = oci_core_vcn.thymesave.default_dhcp_options_id
}

resource "oci_core_security_list" "public" {
  display_name   = "Security List for public subnet"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.thymesave.id

  // allow outgoing traffic
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  // allow ping
  ingress_security_rules {
    source   = local.subnet_public_cidr
    protocol = "1"

    icmp_options {
      type = 3
    }
  }

  // allow ssh from bastion hosts
  ingress_security_rules {
    source   = local.subnet_public_cidr
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }
}
