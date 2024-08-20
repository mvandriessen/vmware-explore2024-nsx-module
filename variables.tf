variable "location" {
  type = string

  validation {
    condition     = contains(["EXPLORE"], var.location)
    error_message = "Location should be EXPLORE."
  }
}
variable "segment_cidr" {
  type    = string
  default = null

  validation {
    condition     = var.segment_cidr == null || can(cidrhost(var.segment_cidr, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "number" {
  type = number
}