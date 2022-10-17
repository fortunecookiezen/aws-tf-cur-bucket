data "aws_iam_policy_document" "key_policy" {
  statement {
    sid       = "AWSConfigKMSPolicy"
    effect    = "Allow"
    resources = [aws_kms_key.cost_and_usage.arn]

    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
  }
}
