
provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "group1" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.group1.location
  resource_group_name = azurerm_resource_group.group1.name
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.group1.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = var.nic-name
  location            = azurerm_resource_group.group1.location
  resource_group_name = azurerm_resource_group.group1.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}



resource "azurerm_virtual_machine" "vm1" {
  name                  = var.vm_name
  location              = azurerm_resource_group.group1.location
  resource_group_name   = azurerm_resource_group.group1.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = "adminuser"
    admin_password = "P@ssw0rd1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}