resource "vault_auth_backend" "fleet_auth" {
  path = "resin_fleet"
  type = "cert"

  description = "Fleet Certificate Authentication"
}

resource "vault_cert_auth_backend_role" "roles" {
  for_each = var.vault_role_policy_map

  name           = each.key
  certificate    = file(lookup(each.value, "certificate"))
  backend        = vault_auth_backend.fleet_auth.path
  token_ttl      = 300
  token_max_ttl  = 600
  token_policies = lookup(each.value, "policies")

  allowed_names = lookup(each.value, "allowed_names", null)
}
