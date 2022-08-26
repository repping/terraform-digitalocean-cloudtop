variable "do_token" {
  description = "The Digital Ocean token."
  type        = string
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
variable "name" {
  type        = string
  default     = "cloudtop"
  description = "The name of the project."
}
variable "size" {
  description = "Desired size of the volume"
  type        = number
  default     = 4
}