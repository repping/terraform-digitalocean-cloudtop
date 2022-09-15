output "droplet_ip" {
  value = digitalocean_droplet.default.ipv4_address
}
output "droplet_ssh_key" {
  value = local_sensitive_file.ssh_keypair.filename
}