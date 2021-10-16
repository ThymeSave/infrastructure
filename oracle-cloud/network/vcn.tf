resource "oci_core_vcn" "thymesave" {
  cidr_block     = local.vcn_cidr
  compartment_id = var.compartment_id
  display_name   = "thymesave"
  dns_label      = "thymesave"
}

resource "oci_core_default_dhcp_options" "thymesave" {
  manage_default_resource_id = oci_core_vcn.thymesave.default_dhcp_options_id
  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type = "SearchDomain"
    search_domain_names = [ "thymesave.local" ]
  }
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_id
  display_name   = "internet-gateway"
  vcn_id         = oci_core_vcn.thymesave.id
}

resource "oci_core_default_route_table" "this" {
  manage_default_resource_id = oci_core_vcn.thymesave.default_route_table_id
  display_name               = "DefaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}
