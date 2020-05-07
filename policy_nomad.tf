data "vault_policy_document" "nomad_server" {
  rule {
    path         = "auth/token/create/nomad-cluster"
    capabilities = ["update"]
  }

  rule {
    path         = "auth/token/roles/nomad-cluster"
    capabilities = ["read"]
  }

  rule {
    path         = "auth/token/lookup-self"
    capabilities = ["read"]
  }

  rule {
    path         = "auth/token/lookup"
    capabilities = ["update"]
  }

  rule {
    path         = "auth/token/revoke-accessor"
    capabilities = ["update"]
  }

  rule {
    path         = "sys/capabilities-self"
    capabilities = ["update"]
  }

  rule {
    path         = "auth/token/renew-self"
    capabilities = ["update"]
  }
}

resource "vault_policy" "nomad_server" {
  count = var.configure_for_nomad ? 1 : 0

  name   = "resin-nomad-server"
  policy = data.vault_policy_document.nomad_server.hcl
}
