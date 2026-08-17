variable "name" {
  description = "Network security group name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the NSG is created."
  type        = string
}

variable "location" {
  description = "Azure region for the NSG."
  type        = string
}

variable "subnet_id" {
  description = "Subnet waaraan deze NSG gekoppeld wordt"
  type        = string
}

variable "security_rules" {
  description = "List of NSG security rules to add to the NSG."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string

    source_port_range          = optional(string)
    destination_port_range     = optional(string)

    source_port_ranges         = optional(list(string))
    destination_port_ranges    = optional(list(string))

    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "biv" {
  description = "Security classification tag, beschikbaarheid-integriteit-vertrouwelijkheid, 1=high 2=medium 3=low."
  type        = string

  validation {
    condition     = can(regex("^[1-3]{3}$", var.biv))
    error_message = "BIV must be three digits between 1 and 3, for example 122."
  }
}

variable "tags" {
  description = "Additional tags. The module-owned biv tag takes precedence."
  type        = map(string)
  default     = {}
}
