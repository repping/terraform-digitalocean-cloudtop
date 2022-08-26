terraform {
  required_version = ">= 1.2.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.22.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.1"
    }
  }
}