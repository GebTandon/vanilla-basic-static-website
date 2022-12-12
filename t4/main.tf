locals {
  tags = merge(var.additional_tags, {
    Company  = "ya3"
    CreateBy = "t4"
    Purpose  = "Learning"
  })
  client_secret   = var.client_secret
  location1       = var.location1
  location2       = var.location2
  location3       = var.location3
  resource_gp1    = var.rg-name1
  resource_gp2    = var.rg-name2
  resource_gp3    = var.rg-name3
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
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
  subscription_id = local.subscription_id
  client_id       = "7d26021c-7b57-46dd-bcbc-a81cf242c115"
  client_secret   = local.client_secret
  tenant_id       = local.tenant_id
}

#Creaste resource group
resource "azurerm_resource_group" "resource_group" {
  name     = local.resource_gp1
  location = local.location1
  tags = merge(
    local.tags, {
      Costing = "no cost"
    },
  )

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_resource_group" "resource_group2" {
  name     = local.resource_gp2
  location = local.location2
  tags = merge(
    local.tags, {
      Company = "Andronix"
      Purpose = "Real"
    },
  )

  lifecycle {
    ignore_changes = [tags]
  }
}


resource "azurerm_resource_group" "resource_group3" {
  name     = local.resource_gp3
  location = local.location3
  tags = merge(
    local.tags, {
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

resource "azurerm_key_vault" "ya3secrets" {
  location                   = local.location3
  sku_name                   = "standard"
  name                       = "ya3secrets"
  resource_group_name        = local.resource_gp3
  tenant_id                  = local.tenant_id
  soft_delete_retention_days = 30

  tags = merge(
    local.tags, {
      Consting = "Min"
      Platform = "node"
    },
  )

  access_policy = [{
    application_id          = ""
    certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers"]
    key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore"]
    object_id               = "000b8ac4-9d40-473f-8f57-4cb05a0c4eae"
    secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
    storage_permissions     = []
    tenant_id               = local.tenant_id
    },
    {
      application_id          = "f123db13-68eb-425b-a9bb-56d73ed7d8c5"
      certificate_permissions = ["List", "Purge"]
      key_permissions         = ["Get", "Import", "WrapKey", "UnwrapKey"]
      object_id               = "9f8bf435-2532-4c7d-8fd0-ced65a29e5fd"
      secret_permissions      = ["Set"]
      storage_permissions     = []
      tenant_id               = local.tenant_id
    }
  ]
  enable_rbac_authorization       = false
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  network_acls  {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = ["99.46.126.148/32"]
    virtual_network_subnet_ids = ["/subscriptions/0a29e980-4c21-4962-95d2-2bf201b2e927/resourceGroups/andronix/providers/Microsoft.Network/virtualNetworks/tempvnet/subnets/db_subvnet", "/subscriptions/0a29e980-4c21-4962-95d2-2bf201b2e927/resourceGroups/andronix/providers/Microsoft.Network/virtualNetworks/tempvnet/subnets/default", "/subscriptions/0a29e980-4c21-4962-95d2-2bf201b2e927/resourceGroups/andronix/providers/Microsoft.Network/virtualNetworks/tempvnet/subnets/ui_subvnet"]
  }
  purge_protection_enabled = false
}


