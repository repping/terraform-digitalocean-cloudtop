variable "hostname" {
  type        = string
  description = "ID of the project to deploy the resources in."
  default     = ""
  validation {
    condition     = var.hostname != ""
    error_message = "Please set the ID for the DigitalOcean project to deploy the resources in. (var.project_id)"
  }
}
variable "path" {
  type        = string
  description = "Path to where the SSH certificates ARE located or WILL BE located after the module generates them."
  default     = "files"
}
variable "key_name" {
  type        = string
  description = "Name of the key to be used as the filename locally and the key name in the DigitalOcean webgui."
  default     = ""
}
variable "do_token" {
  description = "The Digital Ocean token."
  type        = string
  default     = "s-1vcpu-1gb"
}
variable "project_id" {
  type        = string
  description = "ID of the project to deploy the resources in."
  default     = ""
  validation {
    condition     = var.project_id != ""
    error_message = "Please set the ID for the DigitalOcean project to deploy the resources in. (var.project_id)"
  }
}
variable "project_identifier" {
  description = "This string makes this project unique when it is deployed multiple times. Something like a project or deployment prefix/postfix."
  type        = string
  default     = "unset-identifier"
}
variable "droplet_image" {
  type        = string
  description = "Droplet image to use"
  default     = "fedora-36-x64"
}
variable "droplet_size" {
  type        = string
  description = "Resource sizing of the droplet."
  default     = "s-2vcpu-4gb"
}
variable "region" {
  type        = string
  description = "Region to deploy the droplet"
  default     = null
  validation {
    condition     = var.region != null
    error_message = "Please set the ID for the DigitalOcean project to deploy the resources in. (var.project_id)"
  }
}
variable "persistent_home_volume_name" {
  description = "IDs of the persistent home v1olumes that will be attached to the droplet."
  type        = string
  default     = ""
}