resource "azurerm_network_security_rule" "this" {
  for_each = { for rule in var.security_rules : rule.name => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol

  source_port_range           = try(each.value.source_port_range, null)
  destination_port_range      = try(each.value.destination_port_range, null)

  source_port_ranges          = try(each.value.source_port_ranges, null)
  destination_port_ranges     = try(each.value.destination_port_ranges, null)

  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}
