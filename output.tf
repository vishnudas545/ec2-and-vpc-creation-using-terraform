output "prod_url" {

  value = var.my_project_env == "prod" ? "${var.hostname}.${var.domain}" : null
}

output "dev_url" {

  value = var.my_project_env == "dev" ? "${var.hostname}.${var.domain}" : null
}
