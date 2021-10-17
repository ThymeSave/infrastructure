resource "oci_core_volume_backup_policy" "thymesave_persistence" {
  compartment_id = var.compartment_id
  display_name = "ThymeSave Persistence Backup"

  // create every week and store for 2 weeks so at max it stays at 4, below the limit of 5
  schedules {
    #Required
    backup_type       = "FULL"
    period            = "ONE_WEEK"
    retention_seconds = "1209600"

    #Optional
    time_zone      = "UTC"
  }
}

resource "oci_core_volume_backup_policy_assignment" "this" {
  count = length(oci_core_volume.this)
  asset_id  = oci_core_volume.this[count.index].id
  policy_id = oci_core_volume_backup_policy.thymesave_persistence.id
}
