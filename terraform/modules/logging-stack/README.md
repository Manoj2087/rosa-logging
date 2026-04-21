# s3-bucket module

Creates an S3 bucket with secure defaults:

- Server-side encryption enabled (default: SSE-S3 / `AES256`)
- Versioning enabled (default: `true`)
- Public access blocked (default: all block settings `true`)
- Object ownership controls enabled (default: `BucketOwnerEnforced`, disables ACLs)

## Usage

```hcl
module "logs_bucket" {
  source = "./modules/s3-bucket"

  cluster-name = "my-company-logs-prod-us-east-1"
  tags = {
    app = "rosa-logging"
  }
}
```

## KMS encryption (optional)

```hcl
module "logs_bucket" {
  source = "./modules/s3-bucket"

  cluster-name    = "my-company-logs-prod-us-east-1"
  sse_algorithm  = "aws:kms"
  kms_key_id     = "arn:aws:kms:us-east-1:123456789012:key/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

