variable "oidc_endpoint" {
  description = "Cluster OIDC endpoint ID."
  type        = string
}

variable "cluster-name" {
  description = "Name of the cluster"
  type        = string
}

variable "force_destroy" {
  description = "Whether to allow Terraform to destroy the bucket even if it contains objects."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources created by lokistack module."
  type        = map(string)
  default     = {}
}

variable "versioning_enabled" {
  description = "Whether to enable S3 versioning."
  type        = bool
  default     = true
}

variable "object_ownership" {
  description = "Bucket object ownership setting. 'BucketOwnerEnforced' disables ACLs and is recommended."
  type        = string
  default     = "BucketOwnerEnforced"
  validation {
    condition = contains(
      ["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"],
      var.object_ownership
    )
    error_message = "object_ownership must be one of: BucketOwnerEnforced, BucketOwnerPreferred, ObjectWriter."
  }
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for lokistack bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for lokistack bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for lokistack bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for lokistack bucket."
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm. Use 'AES256' or 'aws:kms'."
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "sse_algorithm must be 'AES256' or 'aws:kms'."
  }
}

variable "kms_key_id" {
  description = "KMS key ID/ARN to use when sse_algorithm is 'aws:kms'. Leave null for AWS-managed KMS key."
  type        = string
  default     = null
}
