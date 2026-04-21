variable "oidc_endpoint" {
  description = "Cluster OIDC endpoint ID."
  type        = string
}

variable "cluster-name" {
  description = "Name of the cluster"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources created by lokistack module."
  type        = map(string)
  default     = {}
}
