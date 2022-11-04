output "droplet_ip" {
  value = module.digitalocean_droplet.droplet_ip
}
output "droplet_ssh_key" {
  value = module.digitalocean_droplet.droplet_ssh_key
}
output "how_to_connect_dns" {
  value = "ssh-keygen -R ${var.project_name}.${var.cloudflare_zone}; ssh -i ${module.digitalocean_droplet.droplet_ssh_key} root@${var.project_name}.${var.cloudflare_zone}"
}
output "how_to_connect_ip" {
  value = "ssh -i ${module.digitalocean_droplet.droplet_ssh_key} root@${module.digitalocean_droplet.droplet_ip}"
}
output "mount_persistent_home_volume" {
  value = <<EOF

mkdir -p /mnt/${var.persistent_home_volume_name}; \
mount -o discard,defaults /dev/disk/by-id/scsi-0DO_Volume_${var.persistent_home_volume_name} /mnt/${var.persistent_home_volume_name}; \
echo /dev/disk/by-id/scsi-0DO_Volume_${var.persistent_home_volume_name} /mnt/${var.persistent_home_volume_name} ext4 defaults,nofail,discard 0 0 | sudo tee -a /etc/fstab; \
ln -s /mnt/${var.persistent_home_volume_name}/code ~/code
EOF
}