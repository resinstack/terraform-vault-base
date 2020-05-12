variable "configure_for_nomad" {
  type        = bool
  description = "Configure base policies for use with Nomad."
  default     = true
}

variable "nomad_default_lease_ttl" {
  type        = number
  description = "Default token TTL for Nomad tokens"
  default     = 3600
}

variable "nomad_max_lease_ttl" {
  type        = number
  description = "Max token TTL for Nomad tokens"
  default     = 28800
}
