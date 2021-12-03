variable "azure" {
  description = "Azure configuration"
  type = object({
    location : string
    subscription_id : string
    tenant_id : string
  })
}

variable "resource_prefix" {
  description = "Common resource prefix used for naming Azure resources"
  type        = string
}

variable "tags" {
  type = map(string)
}