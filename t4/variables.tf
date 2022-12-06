variable "location" {
  description = "The Azure Region in which all resources groups should be created."
}

variable "rg-name" {
  description = "The name of the resource group"
}

variable "client_secret" {
  description = "azure app service account password! (aka secret), supplied from t4 remote state"
}

variable "tenant_id" {
  description = "azure tenant id for account used to create resources, supplied from t4 remote state"
}

variable "subscription_id" {
  description = "azure subscription id for the account, supplied from t4 remote state"
}

variable "additional_tags" {
  default = {
    Env = "Prod"
  }
  description = "additional tags for az resources to be merged with those on resources defined in main tf file"
  type        = map(string)
}