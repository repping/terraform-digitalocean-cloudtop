# Generate RSA key of size 4096 bits
resource "tls_private_key" "ssh_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Write the public certificate to file
resource "local_file" "ssh_keypair" {
  content  = tls_private_key.ssh_keypair.public_key_openssh
  filename = "${var.path}/${var.key_name}.pub"
}

# Write the private certificate to file
resource "local_sensitive_file" "ssh_keypair" {
  content  = tls_private_key.ssh_keypair.private_key_openssh
  filename = "${var.path}/${var.key_name}"
}

# Upload the public ssh key for the droplet
resource "digitalocean_ssh_key" "ssh_keypair" {
  name       = var.key_name
  public_key = tls_private_key.ssh_keypair.public_key_openssh
}

# Assign the droplet resource to the project
resource "digitalocean_project_resources" "default" {
  project   = var.project_id
  resources = digitalocean_droplet.default.*.urn
}

# Create the droplet
resource "digitalocean_droplet" "default" {
  image    = var.droplet_image
  name     = var.hostname
  region   = var.region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.ssh_keypair.fingerprint]
}

data "digitalocean_volume" "home" {
  name   = var.volume_home_name
  region = var.region
}

resource "digitalocean_volume_attachment" "foobar" {
  droplet_id = digitalocean_droplet.default.id
  volume_id  = data.digitalocean_volume.home.id
}