resource "oci_core_instance" "node" {
  count = 2

  display_name        = "node${count.index + 1}"
  availability_domain = data.oci_identity_availability_domains.this.availability_domains[count.index].name
  compartment_id      = var.compartment_id
  // ARM Free Tier
  shape = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = 2
    memory_in_gbs = 12
  }

  create_vnic_details {
    subnet_id                 = data.terraform_remote_state.network.outputs.subnet_private_ids[count.index]
    display_name              = "private"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "node${count.index + 1}"
  }

  source_details {
    source_type = "image"
    // Oracle Cloud 8.4 ARM
    source_id = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaapnrktuu7awlssna2kjsgsrnd7cz73ob3c6tehwo22d7hho42pkxa"
  }

  availability_config {
    is_live_migration_preferred = true
  }

  agent_config {
    is_monitoring_disabled   = false
    are_all_plugins_disabled = false
    is_management_disabled   = false

    plugins_config {
      desired_state = "ENABLED"
      name          = "Bastion"
    }

    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Run Command"
    }

    plugins_config {
      desired_state = "ENABLED"
      name          = "Custom Logs Monitoring"
    }

    plugins_config {
      desired_state = "ENABLED"
      name          = "Management Agent"
    }

    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Service Agent"
    }
  }

  metadata = {
    user_data = base64encode(file("./init"))
  }

  lifecycle {
    prevent_destroy = true
  }
}
