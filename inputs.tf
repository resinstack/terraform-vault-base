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

variable "configure_for_consul" {
  type        = bool
  description = "Configure base policies for use with Consul."
  default     = true
}

variable "consul_default_lease_ttl" {
  type        = number
  description = "Default token TTL for Consul tokens"
  default     = 3600
}

variable "consul_max_lease_ttl" {
  type        = number
  description = "Max token TTL for Consul tokens"
  default     = 28800
}

variable "vault_role_policy_map" {
  type = map(object({
    certificate   = string
    policies      = list(string)
    allowed_names = optional(list(string))
  }))
  description = "Mapping of role maps"
  default     = {}
}
