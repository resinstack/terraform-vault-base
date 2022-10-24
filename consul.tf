resource "vault_consul_secret_backend" "consul" {
  count = var.configure_for_consul ? 1 : 0

  path        = "consul"
  description = "Provide tokens for consul"
  address     = var.consul_address
  bootstrap   = var.consul_bootstrap

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

resource "vault_consul_secret_backend_role" "consul_role_root" {
  count   = var.configure_for_consul ? 1 : 0
  backend = vault_consul_secret_backend.consul[0].path

  name            = "root"
  consul_policies = ["global-management"]
}

resource "vault_consul_secret_backend_role" "consul_role_agent" {
  count   = var.configure_for_consul ? 1 : 0
  backend = vault_consul_secret_backend.consul[0].path

  name            = "agent"
  consul_policies = ["resin-consul-agent"]
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

resource "vault_consul_secret_backend_role" "consul_role_vault" {
  count   = var.configure_for_consul ? 1 : 0
  backend = vault_consul_secret_backend.consul[0].path

  name            = "vault"
  consul_policies = ["resin-vault-server"]
}

resource "vault_consul_secret_backend_role" "consul_role_nomad_client" {
  count   = var.configure_for_consul ? 1 : 0
  backend = vault_consul_secret_backend.consul[0].path

  name            = "nomad-client"
  consul_policies = ["resin-nomad-client"]
}

resource "vault_consul_secret_backend_role" "consul_role_nomad_server" {
  count   = var.configure_for_consul ? 1 : 0
  backend = vault_consul_secret_backend.consul[0].path

  name            = "nomad-server"
  consul_policies = ["resin-nomad-server"]
}
