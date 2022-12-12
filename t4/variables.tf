variable "location1" {
  description = "The Azure Region #1 in which resources groups should be created."
}

variable "location2" {
  description = "The Azure Region #2 in which resources groups should be created."
}

variable "location3" {
  description = "The Azure Region #3 in which resources groups should be created."
}

variable "rg-name1" {
  description = "The name of the resource group #1"
}
variable "rg-name2" {
  description = "The name of the resource group #2"
}

variable "rg-name3" {
  description = "The name of the resource group #3"
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