terraform {

  cloud {
    organization = ""
    workspaces {
      name = ""
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.10.0"
    }
  }
}
