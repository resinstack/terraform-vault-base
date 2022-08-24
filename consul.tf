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

resource "vault_generic_endpoint" "consul_role_agent" {
  count      = var.configure_for_consul ? 1 : 0
  depends_on = [vault_mount.consul]

  path                 = "consul/roles/agent"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["resin-consul-agent"]
  })
}

data "vault_policy_document" "consul_agent" {
  rule {
    path         = "resin_internal/data/consul/gossip"
    capabilities = ["read"]
    description  = "Consul gossip key"
  }

  rule {
    path         = "consul/creds/agent"
    capabilities = ["read"]
    description  = "Consul agent role"
  }
}

resource "vault_policy" "consul_agent" {
  count = var.configure_for_consul ? 1 : 0

  name   = "resin-consul-agent"
  policy = data.vault_policy_document.consul_agent.hcl
}

resource "vault_generic_endpoint" "consul_role_vault" {
  count      = var.configure_for_consul ? 1 : 0
  depends_on = [vault_mount.consul]

  path                 = "consul/roles/vault"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["resin-vault-server"]
  })
}

resource "vault_generic_endpoint" "consul_role_nomad_client" {
  count      = (var.configure_for_consul && var.configure_for_nomad) ? 1 : 0
  depends_on = [vault_mount.consul]

  path                 = "consul/roles/nomad-client"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["resin-nomad-client"]
  })
}

resource "vault_generic_endpoint" "consul_role_nomad_server" {
  count      = (var.configure_for_consul && var.configure_for_nomad) ? 1 : 0
  depends_on = [vault_mount.consul]

  path                 = "consul/roles/nomad-server"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["resin-nomad-server"]
  })
}
