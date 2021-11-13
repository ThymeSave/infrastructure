resource "oci_load_balancer_backend_set" "this" {
  name   = "nodes"
  policy = "ROUND_ROBIN"
  health_checker {
    protocol            = "HTTP"
    port                = 3000
    response_body_regex = "."
    url_path            = "/health"
    interval_ms         = 1000
    return_code         = 200
    timeout_in_millis   = 1000
    retries             = 3
  }

  load_balancer_id = oci_load_balancer.this.id
}

resource "oci_load_balancer_backend" "this" {
  count            = length(data.terraform_remote_state.compute.outputs.instance_ips)
  backendset_name  = oci_load_balancer_backend_set.this.name
  ip_address       = data.terraform_remote_state.compute.outputs.instance_ips[count.index]
  load_balancer_id = oci_load_balancer.this.id
  port             = 3000
}
