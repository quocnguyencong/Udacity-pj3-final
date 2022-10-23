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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDATvGdHlPtVZMeJuhPRvCfT7ihMfn8NZPAdhErHEiqr0fsSGhR7ChD5WkyjyTNJWTsy3SJWC3PNWpdi+Ca0Weixyn/xMRbkBCuVdnT5nAK/ORKKRqLcH05LvOZBObq4zIxJaipdfeEGkKbY3c1JLEcdDWty0J7NiC9XkIbSMB0c0NlwRv1lL45qA8RPRPnFknLQubhgYFQYdD2Ghy1c7RCAgUtXpZrJ85+oHxMMjoESmnnRv+7OdSgmbQ1LY3nnRSk50wUJEkuJ5EurB/PhA5SolDK1xc5oDakZ3s9HHtIlizsX1B5yT53PPSRM89qe7ev5vkeMJFIZSUyP4FfqhB34M0mp5ULV83qN96SpLmAyh7ICrhUmeNTn3BdR6QQhfJykfMfh1ngHnfr2H5YaqgnmAXkR1263sn2s3/gKEtGn0AIp9sFUrbrg2Umr/eTKx0u6rwFSs+ZhjLQT4v4VUPBH/t6H68CVeKQzHDHguFFZ2115S+7xYlJxJUtCRAGBc0= devopsagent@myVM"
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
