# Lookup DNS zone.
data "cloudflare_zone" "default" {
  name = var.cloudflare_zone
}

# Create A record
resource "cloudflare_record" "default" {
  zone_id = data.cloudflare_zone.default.id
  name    = "cloudtop"
  value   = module.digitalocean_droplet.droplet_ip
  type    = "A"
  ttl     = 1
  proxied = false
}

# Create the project
module "digitalocean_project" {
  source      = "./modules/terraform-digitalocean-project"
  name        = "${var.project_name}-${var.project_identifier}"
  description = "Owner: Richard Eppingbroek"
  purpose     = "Personal Fedora Workstation/Development server in the Cloud."
  environment = "production"
}

# Create the host
module "digitalocean_droplet" {
  source                      = "./modules/terraform-digitalocean-droplet"
  project_id                  = module.digitalocean_project.project.id
  project_identifier          = var.project_identifier
  hostname                    = var.project_name
  persistent_home_volume_name = var.persistent_home_volume_name
  key_name                    = "${var.project_name}-${var.project_identifier}_ssh"
  region                      = "ams3"
  droplet_size                = "s-1vcpu-1gb"
}