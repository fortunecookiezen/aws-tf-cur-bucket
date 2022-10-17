data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowBucketOperations"
    effect    = "Allow"
    resources = [aws_s3_bucket.cost_and_usage.arn]

    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy",
      "s3:ListBucket"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cur:us-east-1:${data.aws_caller_identity.current.account_id}:definition/*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
  }

  statement {
    sid       = "AllowObjectOperations"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.cost_and_usage.arn}/*"]
    actions   = ["s3:PutObject"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cur:us-east-1:${data.aws_caller_identity.current.account_id}:definition/*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
  }

  statement {
    sid       = "BackwardCompatibleBillingBucketOperations"
    effect    = "Allow"
    resources = [aws_s3_bucket.cost_and_usage.arn]

    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy",
      "s3:ListBucket",
    ]

    principals {
      type        = "AWS"
      identifiers = [data.aws_billing_service_account.current.arn]
    }
  }

  statement {
    sid       = "BackwardCompatibleBillingObjectOperations"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.cost_and_usage.arn}/*"]
    actions   = ["s3:PutObject"]

    principals {
      type        = "AWS"
      identifiers = [data.aws_billing_service_account.current.arn]
    }
  }
}
