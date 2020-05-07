resource "vault_token_auth_backend_role" "nomad_cluster" {
  role_name              = "nomad-cluster"
  disallowed_policies    = ["resin-nomad-server"]
  orphan                 = true
  renewable              = true
  token_period           = 259200
  token_explicit_max_ttl = 0
}
