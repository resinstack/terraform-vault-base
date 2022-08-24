resource "vault_mount" "resin_internalkv" {
  path        = "resin_internal"
  type        = "kv"
  options     = { version = "2" }
  description = "v2 KV Storage - ResinStack Internal"
}

data "vault_policy_document" "vault_server" {
  rule {
    path         = "resin_internal/data/vault/consul_token"
    capabilities = ["read"]
    description  = "Consul ACL token"
  }
}

resource "vault_policy" "vault_server" {
  count = var.configure_for_consul ? 1 : 0

  name   = "resin-vault-server"
  policy = data.vault_policy_document.vault_server.hcl
}
