variable "configure_for_nomad" {
  type        = bool
  description = "Configure base policies for use with Nomad."
  default     = true
}

variable "configure_for_nomad_acl" {
  type        = bool
  description = "Configure nomad secrets engine"
  default     = true
}

variable "nomad_address" {
  type        = string
  description = "Nomad API Address"
  default     = "http://localhost:4646"
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

variable "nomad_mint_global_tokens" {
  type        = bool
  description = "Mint global tokens for default roles"
  default     = false
}

variable "configure_for_consul" {
  type        = bool
  description = "Configure base policies for use with Consul."
  default     = true
}

variable "consul_address" {
  type        = string
  description = "Consul API address"
  default     = "http://localhost:8500"
}

variable "consul_bootstrap" {
  type        = bool
  description = "Bootstrap the Consul ACL system"
  default     = false
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

variable "machine_auth_ttl" {
  type        = number
  description = "Default TTL for tokens"
  default     = 300
}

variable "machine_auth_max_ttl" {
  type        = number
  description = "Max TTL for machine authenticated tokens"
  default     = 600
}
