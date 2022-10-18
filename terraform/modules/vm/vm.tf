resource "azurerm_network_interface" "test" {
  name                = "NIC-test"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  #admin_username      = "${var.admin_username}"
  admin_username      = "adminuser" 
  network_interface_ids = ["${azurerm_network_interface.test.id}"]
  admin_ssh_key {
    #username   = "${var.admin_username}"
    username   = "adminuser"
    public_key = ""
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
