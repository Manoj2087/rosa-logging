module "logging-stack" {
  source = "./modules/logging-stack"
  oidc_endpoint = "${var.oidc_endpoint}"
  cluster-name = "${var.cluster-name}"
#   tags = "${var.tags}"
#   force_destroy = false
#   versioning_enabled = true
#   object_ownership = "BucketOwnerEnforced"
#   block_public_acls = true
#   ignore_public_acls = true
#   block_public_policy = true
#   restrict_public_buckets = true
#   sse_algorithm = "AES256"
#   kms_key_id = ""
}