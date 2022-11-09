resource "oci_network_load_balancer_backend_set" "this" {
  health_checker {
    protocol            = "TCP"
    interval_in_millis  = 9000
    port                = 3000
    response_body_regex = "."
    retries             = 3
    return_code         = 200
    timeout_in_millis   = 3000
    url_path            = "/health"
  }
  name                     = "nodes"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.this.id
  policy                   = "FIVE_TUPLE"
}

resource "oci_network_load_balancer_backend" "this" {
  count                    = length(data.terraform_remote_state.compute.outputs.instance_ips)
  backend_set_name         = oci_network_load_balancer_backend_set.this.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.this.id
  port                     = 3000
  ip_address               = data.terraform_remote_state.compute.outputs.instance_ips[count.index]
}

