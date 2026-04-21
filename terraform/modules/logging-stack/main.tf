data "aws_partition" "current" {}

# Create S3 bucket for LokiStack Operator
resource "aws_s3_bucket" "lokistack" {
  bucket_prefix = "${var.cluster-name}-logging-"
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_public_access_block" "lokistack" {
  bucket = aws_s3_bucket.lokistack.id

  block_public_acls       = var.block_public_acls
  ignore_public_acls      = var.ignore_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "lokistack" {
  bucket = aws_s3_bucket.lokistack.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_versioning" "lokistack" {
  bucket = aws_s3_bucket.lokistack.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lokistack" {
  bucket = aws_s3_bucket.lokistack.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.sse_algorithm == "aws:kms" ? var.kms_key_id : null
    }
  }
}

# Create IAM policy to access the log bucket for LokiStack Operator 
resource "aws_iam_policy" "lokistack_access" {
  name = "${var.cluster-name}-lokistack-access-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "LokiStorage"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.lokistack.id}",
          "arn:aws:s3:::${aws_s3_bucket.lokistack.id}/*"
        ]
      }
    ]
  })
  tags = var.tags
}


# Create an IAM Role and link the trust policy to the LokiStack Operator
# Note: logging-collector = The name of the OpenShift service account used by log collector
resource "aws_iam_role" "lokistack" {
  name = "${var.cluster-name}-lokistack-accessrole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Condition = {
          StringEquals = {
            "${var.oidc_endpoint}:sub": [
              "system:serviceaccount:openshift-logging:logging-collector",
              "system:serviceaccount:openshift-logging:logging-loki"
            ]
          }
        }
        Principal = {
          "Federated": "arn:aws:iam::${data.aws_partition.current.partition}:oidc-provider/${var.oidc_endpoint}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
      }
    ]
  })
  tags = var.tags
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "lokistack" {
  role       = aws_iam_role.lokistack.name
  policy_arn = aws_iam_policy.lokistack_access.arn
}