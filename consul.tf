resource "vault_mount" "consul" {
  count = var.configure_for_consul ? 1 : 0

  type        = "consul"
  path        = "consul/"
  description = "Provide tokens for consul"

  default_lease_ttl_seconds = var.consul_default_lease_ttl
  max_lease_ttl_seconds     = var.consul_max_lease_ttl
}

data "vault_policy_document" "consul_root" {
  rule {
    path = "consul/*"

    capabilities = [
      "create",
      "read",
      "update",
      "delete",
      "list",
      "sudo",
    ]

    description = "Full access to configure the consul secret backend"
  }
}

resource "vault_policy" "consul_root" {
  count = var.configure_for_consul ? 1 : 0

  name   = "resin-consul-root"
  policy = data.vault_policy_document.consul_root.hcl
}

resource "vault_generic_endpoint" "consul_role_root" {
  count      = var.configure_for_consul ? 1 : 0
  depends_on = [vault_mount.consul]

  path                 = "consul/roles/root"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["global-management"]
  })
}
