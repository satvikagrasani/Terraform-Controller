resource "azurerm_network_interface" "nic" {
  count               = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_public_ip" "pip" {
  count               = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = length(var.vm_names)
  name                = var.vm_names[count.index]
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
