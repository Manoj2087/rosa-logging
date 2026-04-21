output "bucket_id" {
  description = "Bucket ID (same as bucket name)."
  value       = aws_s3_bucket.lokistack.id
}

output "bucket_arn" {
  description = "Bucket ARN."
  value       = aws_s3_bucket.lokistack.arn
}

output "lokistack_iam_role_arn" {
  description = "LokiStack IAM role ARN."
  value       = aws_iam_role.lokistack.arn
}


# output "cluster-name" {
#   description = "Bucket name."
#   value       = aws_s3_bucket.lokistack.bucket
# }

# output "region" {
#   description = "AWS region where the bucket is created (from provider configuration)."
#   value       = data.aws_region.current.name
# }

