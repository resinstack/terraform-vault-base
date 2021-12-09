data "vault_policy_document" "root" {
  rule {
    path = "auth/*"

    capabilities = [
      "create",
      "read",
      "update",
      "delete",
      "list",
      "sudo",
    ]

    description = "Manage auth methods broadly across Vault"
  }

  rule {
    path = "sys/audit/*"

    capabilities = [
      "create",
      "update",
      "delete",
      "sudo",
    ]

    description = "CRUD on audit devices"
  }

  rule {
    path         = "sys/audit"
    capabilities = ["sudo", "read"]
    description  = "Allow reading of audit devices"
  }

  rule {
    path = "sys/auth/*"

    capabilities = [
      "create",
      "update",
      "delete",
      "sudo",
    ]

    description = "CRUD on auth methods"
  }

  rule {
    path         = "sys/auth"
    capabilities = ["read"]
    description  = "List configured auth methods"
  }

  rule {
    path = "sys/step-down"
    capabilities = [
      "sudo",
      "update",
    ]
    description = "Permit root user to step down the active vault"
  }

  rule {
    path = "sys/policies/acl"
    capabilities = [
      "read",
      "list",
    ]
    description = "List configured policies"
  }

  rule {
    path = "sys/policies/acl/*"

    capabilities = [
      "create",
      "read",
      "update",
      "delete",
      "list",
      "sudo",
    ]

    description = "Create/manage ACL policies"
  }

  rule {
    path = "sys/plugins/*"

    capabilities = [
      "create",
      "read",
      "update",
      "delete",
      "list",
      "sudo",
    ]

    description = "Manage plugin parameters"
  }

  rule {
    path = "secret/*"

    capabilities = [
      "create",
      "read",
      "update",
      "delete",
      "list",
      "sudo",
    ]

    description = "Complete management for K/V secrets"
  }

  rule {
    path = "sys/mounts/*"

    capabilities = [
      "create",
      "read",
      "update",
      "delete",
      "list",
      "sudo",
    ]

    description = "Manage secret engines"
  }

  rule {
    path         = "sys/remount"
    capabilities = ["sudo", "update"]
    description  = "Allow moving mounts around."
  }

  rule {
    path         = "sys/mounts"
    capabilities = ["read"]
    description  = "List existing secret engines."
  }

  rule {
    path = "sys/health"

    capabilities = [
      "read",
      "sudo",
    ]

    description = "Read health checks"
  }

  rule {
    path = "identity/*"
    capabilities = [
      "create",
      "read",
      "update",
      "delete",
      "list",
      "sudo",
    ]

    description = "Allow management of identity systems."
  }
}

resource "vault_policy" "root" {
  name   = "resin-root"
  policy = data.vault_policy_document.root.hcl
}
