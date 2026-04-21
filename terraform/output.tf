output "bucket_id" {
  description = "Bucket ID (same as bucket name)."
  value       = module.logging-stack.bucket_id
}

output "bucket_arn" {
  description = "Bucket ARN."
  value       = module.logging-stack.bucket_arn
}

output "lokistack_iam_role_arn" {
  description = "LokiStack IAM role ARN."
  value       = module.logging-stack.lokistack_iam_role_arn
}