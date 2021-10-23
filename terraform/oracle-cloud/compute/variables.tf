variable "user_ocid" {
  description = "OCID of the user for the provider"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint to use for for the provider"
  type        = string
}

variable "tenancy_ocid" {
  description = "OCID of the oracle cloud tenancy for the provider"
  type        = string
}

variable "compartment_id" {
  description = "Compartment to create resources in"
  type        = string
}
