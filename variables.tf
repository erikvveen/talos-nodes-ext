variable "region" {
    description = "Region to deploy the Linode instances"
    type        = string
    default     = "us-east"
}

variable "instance_type" {
    description = "Type of Linode instance to deploy"
    type        = string
    default     = "g6-standard-2"
}

variable "image" {
    description = "Image to deploy"
    type        = string
    default     = "private/28864823"
}

variable "metadata_options" {
    description = "Machine configuration"
    type        = string
    default     = "talos"
}

variable "name" {
    description = "Name of the Linode instance"
    type        = string
    default     = "talos-control-plane"
}

variable "tags" {
    description = "Tags for the Linode instance"
    type        = list(string)
    default     = []
}

# variable "network_interface" {
#   description = "Customize network interfaces to be attached at instance boot time"
#   type        = list(map(string))
#   default     = []
# }

variable "create" {
  description = "Whether to create an instance"
  type        = bool
  default     = true
}
