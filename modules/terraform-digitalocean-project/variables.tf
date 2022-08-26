variable "name" {
  type        = string
  default     = "cloudtop"
  description = "The name of the project."
}
variable "description" {
  type        = string
  default     = "That time Richard stole Roberts CloudTop code..."
  description = "The description of the project."
}
variable "purpose" {
  type        = string
  default     = "Hosting a Fedora Workstation desktop environment in the cloud."
  description = "The purpose of the project."
}
variable "environment" {
  type        = string
  default     = "Production"
  description = "The environment of the project."
}
variable "path" {
  type        = string
  description = "Path to where the SSH certificates ARE located or WILL BE located after the module generates them."
  default     = ""
}
variable "key_name" {
  type        = string
  description = "Name of the key to be used as the filename locally and the key name in the DigitalOcean webgui."
  default     = ""
}