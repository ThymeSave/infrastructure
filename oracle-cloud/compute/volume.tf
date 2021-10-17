resource "oci_core_volume" "this" {
  count = length(oci_core_instance.node)
  availability_domain = data.oci_identity_availability_domains.this.availability_domains[count.index].name
  compartment_id      = var.compartment_id
  display_name = "node${count.index + 1}-persistence"
  is_auto_tune_enabled = true
  size_in_gbs = "50"
  vpus_per_gb = "120"

  lifecycle {
    prevent_destroy = true
  }
}

resource "oci_core_volume_attachment" "this" {
  count = length(oci_core_instance.node)
  attachment_type = "PARAVIRTUALIZED"
  instance_id     = oci_core_instance.node[count.index].id
  volume_id       = oci_core_volume.this[count.index].id
  display_name = "node${count.index + 1}-persistence"
  device = "/dev/oracleoci/oraclevdc"
  is_read_only = false
  is_shareable = true
}
