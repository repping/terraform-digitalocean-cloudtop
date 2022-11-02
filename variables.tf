variable "region" {
  description = "Region for the DO resources to be deployed in."
  type        = string
  default     = "ams3"
}
variable "do_token" {
  description = "The Digital Ocean token."
  type        = string
}
variable "project_name" {
  description = "Name of the project that is being deployed in DigitalOcean."
  type        = string
  default     = "unset-project-name"
}
variable "project_identifier" {
  description = "This string makes this project unique when it is deployed multiple times. Something like a project or deployment prefix/postfix."
  type        = string
  default     = "unset-identifier"
}
variable "cloudflare_zone" {
  description = "Name of the domain used in cloudflare."
  type        = string
  default     = ""
  validation {
    condition     = var.cloudflare_zone != ""
    error_message = "Cloudflare zone/domain not set."
  }
}
variable "cloudflare_token" {
  description = "API token for Cloudflare."
  type        = string
  default     = ""
  validation {
    condition     = var.cloudflare_token != ""
    error_message = "Cloudflare API token not set."
  }
}
variable "persistent_home_volume_name" {
  description = "Name of the digitalocean volume to attach as the volume where the /home folder will be mounted. This is to keep personal data when the droplet is destroyed to save cost."
  type        = string
  default     = ""
}
variable "persistent_home_volume_from_snapshot" {
  description = "Boolean to enable the creation of the persistent home volume from an existing snapshot."
  type        = bool
  default     = false
}
variable "persistent_volume_snapshot_name" {
  description = "Name of the snapshot to use for the creation of the persistent home volume. Only applicable when persistent_home_volume_from_snapshot is set to true."
  type        = string
  default     = ""
}