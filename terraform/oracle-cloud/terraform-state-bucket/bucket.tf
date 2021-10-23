resource "oci_objectstorage_bucket" "state" {
  compartment_id = var.compartment_id
  name           = "terraform-state"
  namespace      = data.oci_objectstorage_namespace.this.namespace
  access_type    = "NoPublicAccess"
  versioning     = "Enabled"
}
