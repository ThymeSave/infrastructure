resource "oci_load_balancer" "this" {
  compartment_id = var.compartment_id
  display_name   = "funnel"
  shape          = "flexible"
  subnet_ids     = slice(data.terraform_remote_state.network.outputs.subnet_public_ids, 0, 2)
  is_private     = false

  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_listener" "this" {
  default_backend_set_name = oci_load_balancer_backend_set.this.name
  load_balancer_id         = oci_load_balancer.this.id
  name                     = "funnel-http"
  port                     = 80
  protocol                 = "HTTP"
}
