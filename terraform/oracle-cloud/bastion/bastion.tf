resource "oci_bastion_bastion" "this" {
  bastion_type                 = "STANDARD"
  name = "bastion1"
  compartment_id               = var.compartment_id
  target_subnet_id             = data.terraform_remote_state.network.outputs.subnet_bastion_id
  client_cidr_block_allow_list = [
    "0.0.0.0/0"
  ]
  max_session_ttl_in_seconds = 10800 // = 3 hours (max)
}
