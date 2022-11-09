resource "oci_core_network_security_group" "this" {
    compartment_id = var.compartment_id
    vcn_id         = data.terraform_remote_state.network.outputs.vnc_id
}


resource "oci_core_network_security_group_security_rule" "https" {
  network_security_group_id = oci_core_network_security_group.this.id

  description = "HTTP"
  direction   = "INGRESS"
  protocol    = 6
  source_type = "CIDR_BLOCK"
  source      = "0.0.0.0/0"
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
}

resource "oci_network_load_balancer_network_load_balancer" "this" {
  compartment_id                 = var.compartment_id
  display_name                   = "thymesave"
  subnet_id                      = data.terraform_remote_state.network.outputs.subnet_public_ids[0]
  is_preserve_source_destination = false
  is_private                     = false
  nlb_ip_version                 = "IPV4"
  network_security_group_ids     = [oci_core_network_security_group.this.id]
}

resource "oci_network_load_balancer_listener" "http" {
  default_backend_set_name = oci_network_load_balancer_backend_set.this.name
  name                     = "http"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.this.id
  port                     = 80
  protocol                 = "TCP"
  ip_version               = "IPV4"
}

