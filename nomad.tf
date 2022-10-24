data "vault_policy_document" "nomad_root" {
  rule {
    path = "nomad/*"

    capabilities = [
      "create",
      "read",
      "update",
      "delete",
      "list",
      "sudo",
    ]

    description = "Full access to configure the nomad secret backend"
  }
}

resource "vault_policy" "nomad_root" {
  count = var.configure_for_nomad ? 1 : 0

  name   = "resin-nomad-root"
  policy = data.vault_policy_document.nomad_root.hcl
}

resource "vault_nomad_secret_backend" "nomad" {
  count = var.configure_for_nomad ? 1 : 0

  description = "Provide tokens for nomad"
  address     = var.nomad_address

  default_lease_ttl_seconds = var.nomad_default_lease_ttl
  max_lease_ttl_seconds     = var.nomad_max_lease_ttl
  ttl                       = var.nomad_default_lease_ttl
  max_ttl                   = var.nomad_max_lease_ttl
}

resource "vault_nomad_secret_role" "nomad_root" {
  count   = var.configure_for_nomad ? 1 : 0
  backend = vault_nomad_secret_backend.nomad[0].backend

  role     = "root"
  policies = ["root"]
  global   = var.nomad_mint_global_tokens
}

resource "vault_nomad_secret_role" "nomad_management" {
  count   = var.configure_for_nomad ? 1 : 0
  backend = vault_nomad_secret_backend.nomad[0].backend

  role   = "management"
  type   = "management"
  global = var.nomad_mint_global_tokens
}
