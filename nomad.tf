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

resource "vault_mount" "nomad" {
  count = var.configure_for_nomad ? 1 : 0

  path        = "nomad/"
  type        = "nomad"
  description = "Provide tokens for nomad"

  default_lease_ttl_seconds = var.nomad_default_lease_ttl
  max_lease_ttl_seconds     = var.nomad_max_lease_ttl
}

resource "vault_generic_endpoint" "nomad_token_ttl" {
  count      = var.configure_for_nomad ? 1 : 0
  depends_on = [vault_mount.nomad]

  path                 = "nomad/config/lease"
  ignore_absent_fields = true

  data_json = jsonencode({
    ttl     = var.nomad_default_lease_ttl
    max_ttl = var.nomad_max_lease_ttl
  })
}

resource "vault_generic_endpoint" "nomad_role_root" {
  count      = var.configure_for_nomad ? 1 : 0
  depends_on = [vault_mount.nomad]

  path                 = "nomad/role/root"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["root"]
  })
}
