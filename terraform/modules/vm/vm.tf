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
  #admin_username     = "${var.admin_username}"
  admin_username      = "adminuser" 
  network_interface_ids = ["${azurerm_network_interface.test.id}"]
  source_image_id      = "${var.vm_image_id}"
  disable_password_authentication = true
  admin_ssh_key {
    #username   = "${var.admin_username}"
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXW0Ij9bvEspXvK+oPsYMY2zuV5XaNk6OB3BmIsq1JYS2syCr/xANtVi30cmQOhHNGXQCye9z41F+v8OOrFpXbBBFm31EaIZ7VMcApc5mnUlutm1OAv0vnezjheawqeySPo002ufLce+RxJSHnuXRFgnnW9B4y1bbkVJ8jR5inD9cbZmL1OEdpPzqhl5sCf1/6F5Ayqlg/iVLJKpTaul45yMdXIlyYaa+xXY/Hs6Cuc67pqBtjztUhOJu8PSFOFqAOVY4UzZwlc9ym6LfOp+0O+JKwTWnK/0DKeepbyr1i9VQR/hBr1lR4S2VIxKFdid18rM0DOl3gWtBAb5UxjRVX0yDoAUqJN9N8nww26Ni2/EtmTOfTj7/jnA3HSplb8Pgf3Efgrk5sEm4hOrWeV8WKRF7V2NpGo+OJUxTRETpwh3Pg5IgxrlBJL0rY/TW+WVFGEm8wBALjJ98ZHzKNyYfxtaczAD8q10m7SfX7WLPUGRkRwKXLqnGmMI3DuLIns9E= quoc@quoc-VirtualBox"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  # source_image_reference {
  #   publisher = "Canonical"
  #   offer     = "UbuntuServer"
  #   sku       = "18.04-LTS"
  #   version   = "latest"
  # }
}
