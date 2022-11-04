# Generate RSA SSH key of size 4096 bits ONLY if it does not allready exist at the "var.path/var.keyname"
resource "tls_private_key" "ssh_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_keypair" {
  content  = tls_private_key.ssh_keypair.public_key_openssh
  filename = "${var.path}/${var.key_name}.pub"
}

resource "local_sensitive_file" "ssh_keypair" {
  content  = tls_private_key.ssh_keypair.private_key_openssh
  filename = "${var.path}/${var.key_name}"
}

resource "digitalocean_ssh_key" "ssh_keypair" {
  name       = var.key_name
  public_key = tls_private_key.ssh_keypair.public_key_openssh
}

resource "digitalocean_project_resources" "default" {
  project   = var.project_id
  resources = digitalocean_droplet.default.*.urn
}

resource "digitalocean_droplet" "default" {
  image    = var.droplet_image
  name     = var.hostname
  region   = var.region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.ssh_keypair.fingerprint]
}

# Create and attach volume from a user provided SNAPSHOT.
data "digitalocean_volume_snapshot" "snapshot-home" {
  count = var.persistent_home_volume_from_snapshot == true ? 1 : 0
  name  = var.persistent_home_volume_snapshot_name
}

resource "digitalocean_volume" "snapshot-home" {
  count       = var.persistent_home_volume_from_snapshot == true ? 1 : 0
  region      = var.region
  name        = var.persistent_home_volume_name
  size        = data.digitalocean_volume_snapshot.snapshot-home[0].min_disk_size
  snapshot_id = data.digitalocean_volume_snapshot.snapshot-home[0].id
}

# Attach volume when from  a user provided VOLUME.
data "digitalocean_volume" "default" {
  count  = var.persistent_home_volume_from_snapshot == true ? 0 : 1
  name   = var.persistent_home_volume_name
  region = var.region
}

resource "digitalocean_volume_attachment" "default" {
  droplet_id = digitalocean_droplet.default.id
  volume_id  = try(digitalocean_volume.snapshot-home[0].id, data.digitalocean_volume.default[0].id)
}