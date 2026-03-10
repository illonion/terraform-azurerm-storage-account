resource "random_string" "random" {
  length  = 24
  special = false
  upper   = false
}

resource "azurerm_storage_account" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  # ---- All hardcoded for testing ----
  account_tier             = "Standard"
  account_replication_type = "LRS"      # cheapest for testing
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Security
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true
  public_network_access_enabled   = true  # true for easy testing

  # Blob config
  blob_properties {
    versioning_enabled = false

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }

  # Tags
  tags = merge(
    {
      ManagedBy   = "Terraform"
      Environment = "Testing"
    },
    var.tags,
  )
}
