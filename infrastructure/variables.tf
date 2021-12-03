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

variable "kubernetes" {
  description = "Kubernetes configuration"
  type = object({
    authorized_ip_ranges : list(string)
    enable_auto_scaling : string
    max_count : number
    min_count : number
    node_count : number
    vm_size : string
    vm_zones : list(number)
  })
}

variable "tags" {
  type = map(string)
}