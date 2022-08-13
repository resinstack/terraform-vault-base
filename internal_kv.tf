resource "vault_mount" "resin_internalkv" {
  path        = "resin_internal"
  type        = "kv"
  options     = { version = "2" }
  description = "v2 KV Storage - ResinStack Internal"
}
