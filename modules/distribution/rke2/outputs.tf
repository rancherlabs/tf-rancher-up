output "rke2_server_user_data" {
  depends_on  = [var.dependency]
  description = "RKE2 server user data"
  value = templatefile("${path.module}/server_config.yaml.tpl",
    {
      rke2_config  = var.rke2_config == null ? "false" : var.rke2_config,
      rke2_token   = local.rke2_token,
      rke2_version = var.rke2_version == null ? "false" : var.rke2_version,
      server_ip    = var.first_server_ip == null ? "false" : var.first_server_ip
    }
  )
}

output "rke2_worker_user_data" {
  depends_on  = [var.dependency]
  description = "RKE2 worker user data"
  value = templatefile("${path.module}/worker_config.yaml.tpl",
    {
      rke2_config  = var.rke2_config == null ? "false" : var.rke2_config,
      rke2_token   = local.rke2_token,
      rke2_version = var.rke2_version == null ? "false" : var.rke2_version,
      server_ip    = var.first_server_ip == null ? "false" : var.first_server_ip
    }
  )
}

output "rke2_token" {
  description = "Token generated for RKE2"
  value       = var.rke2_token == null && var.first_server_ip == null ? random_password.token.result : var.rke2_token
  sensitive   = true
}
