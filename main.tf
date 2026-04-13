resource "azurerm_storage_account" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  public_network_access_enabled = var.public_network_access_enabled

  # Hardcoded values
  account_kind             = "StorageV2"
  // Valid options are - BlobStorage, BlockBlobStorage, FileStorage, Storage, QueueStorage, and StorageV2
  // StorageV2 is the most versatile. FileStorage and QueueStorage are for specific use cases
  account_tier             = "Standard"
  // Standard or Premium
  account_replication_type = "LRS"
  // How do they want the data to be replicated?
  // Valid options are - LRS, GRS, ZRS, GZRS, RAGRS, and RAGZRS
  access_tier              = "Hot"
  // What access tier is wanted? - Hot, Cool, Cold 

  min_tls_version                 = "TLS1_2"
  // TLS V1.2 is the minimum. Goes up to TLS 3.
  https_traffic_only_enabled      = true
  // Prevents HTTP traffic
  allow_nested_items_to_be_public = false
  // Allows or disallows nested items within this account to be public
  shared_access_key_enabled       = true
  // IF you guys have a shared key, having the storage account would allow access via it.
  // Otherwise they must be authorised with Azaure Active Directory (Azure AD)

  blob_properties {
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }

  tags = var.tags
}
