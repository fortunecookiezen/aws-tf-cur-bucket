terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data "aws_billing_service_account" "current" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# s3 bucket
resource "aws_s3_bucket" "cost_and_usage" {
  bucket = var.report_bucket_name != "" ? var.report_bucket_name : "${var.prefix}-cur-reports-${data.aws_region.current.name}"
  tags   = merge(var.tags, var.bucket_tags)
}

# s3 bucket policy
resource "aws_s3_bucket_policy" "allow_billing_access" {
  bucket = aws_s3_bucket.cost_and_usage.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

# s3 public access block
resource "aws_s3_bucket_public_access_block" "cost_and_usage" {
  bucket = aws_s3_bucket.cost_and_usage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# s3 bucket versioning 
resource "aws_s3_bucket_versioning" "cost_and_usage" {
  bucket = aws_s3_bucket.cost_and_usage.id
  versioning_configuration {
    status = "Enabled"
  }
}

# s3 bucket logging

# s3 bucket server side encryption encryption configuration
resource "aws_kms_key" "cost_and_usage" {
  description             = "Encryption key for ${aws_s3_bucket.cost_and_usage.id}"
  deletion_window_in_days = 10
  policy = data.aws_iam_policy_document.key_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cost_and_usage" {
  bucket = aws_s3_bucket.cost_and_usage.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.cost_and_usage.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# s3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "cost_and_usage" {
  bucket = aws_s3_bucket.cost_and_usage.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}