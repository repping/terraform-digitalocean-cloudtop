resource "digitalocean_project" "default" {
  name        = var.name
  description = var.description
  purpose     = var.purpose
  environment = var.environment
}