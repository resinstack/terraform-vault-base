output "consul_secret_backend" {
  value       = var.configure_for_consul ? vault_consul_secret_backend.consul[0].path : null
  description = "Backend path for consul secrets engine"
}

output "nomad_secret_backend" {
  value       = var.configure_for_nomad ? vault_nomad_secret_backend.nomad[0].backend : null
  description = "Backend path for nomad secrets engine"
}
