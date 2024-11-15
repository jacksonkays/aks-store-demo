terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.113.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "=2.5.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "=3.6.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

    cognitive_account {
      purge_soft_delete_on_destroy = true
    }

    key_vault {
      purge_soft_delete_on_destroy = true
    }

    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
  }
}

provider "azurerm"{
  alias = "secondary"
  subscription_id = "3de261df-f2d8-4c00-a0ee-a0be30f1e48e"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "random_integer" "example" {
  min = 10
  max = 99
}

resource "random_pet" "example" {
  length    = 2
  separator = ""
  keepers = {
    location = var.location
  }
}

data "http" "ifconfig" {
  url = "http://ifconfig.me"
}

data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "example" {
  name     = var.resource_group_name
}

data "azurerm_kubernetes_cluster" "example" {
  provider            = azurerm.secondary
  name                = "shared-cluster-01"
  resource_group_name = "jackkays-test"
}
