# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnets
resource "azurerm_subnet" "subnets" {
  count               = length(var.subnet_names)
  name                = var.subnet_names[count.index]
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = ["10.1.${count.index + 1}.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "web-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG to Subnets

resource "azurerm_subnet_network_security_group_association" "assoc" {
  count                     = length(var.subnet_names)
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
