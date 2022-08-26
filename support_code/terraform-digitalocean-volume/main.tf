resource "digitalocean_volume" "default" {
  region                  = var.region
  name                    = var.name
  size                    = var.size
  initial_filesystem_type = "ext4"
  description             = "Seperate home volume for a cloudtop instance."
}