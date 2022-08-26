terraform {
  required_version = ">= 1.2.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.22.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.22.0"
    }
  }
}