output "how_to_connect_dns" {
  value = "ssh -i ${module.digitalocean_droplet.droplet_ssh_key} root@${var.project_name}.${var.cloudflare_zone}"
}
output "how_to_connect_ip" {
  value = "ssh -i ${module.digitalocean_droplet.droplet_ssh_key} root@${module.digitalocean_droplet.droplet_ip}"
}