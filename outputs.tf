output "consul_secret_backend" {
  value       = var.configure_for_consul ? vault_consul_secret_backend.consul[0].path : null
  description = "Backend path for consul secrets engine"
}

output "nomad_secret_backend" {
  value       = var.configure_for_nomad ? vault_nomad_secret_backend.nomad[0].backend : null
  description = "Backend path for nomad secrets engine"
}

output "fleet_auth_backend_path" {
  value       = var.configure_machine_certauth ? vault_auth_backend.fleet_auth[0].path : null
  description = "Backend for fleet authentication."
}
