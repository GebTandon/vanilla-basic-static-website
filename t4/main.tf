locals {
  tags = merge(var.additional_tags, {
    Company  = "ya3"
    CreateBy = "t4"
    Purpose  = "Learning"
  })
  client_secret   = var.client_secret
  location        = var.location
  resource_gp     = var.rg-name
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = local.subscription_id
  client_id       = "7d26021c-7b57-46dd-bcbc-a81cf242c115"
  client_secret   = local.client_secret
  tenant_id       = local.tenant_id
}

#Creaste resource group
resource "azurerm_resource_group" "resource_group" {
  name     = local.resource_gp
  location = local.location
  tags = merge(
    local.tags, {
      Costing = "no cost"
    },
  )

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "stc-web-plan"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  os_type             = "Linux"
  sku_name            = "F1"

  tags = merge(
    local.tags, {
      Costing = "free"
    },
  )

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "stc-webapp-6634av"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  #(Optional)
  # with default site config, the alwaysON should be false, and 32bit worker true, for F1 service plan!!
  site_config {
    use_32_bit_worker = true
    always_on         = false
    app_command_line  = "node index.js"
    # # always_on         = true
    # default_documents = ["index.html"]

    # application_stack {
    #   node_version = "16-lts"
    # }
  }

  tags = merge(
    local.tags, {
      Os       = "linux"
      Platform = "node"
    },
  )

  lifecycle {
    ignore_changes = [tags]
  }

}