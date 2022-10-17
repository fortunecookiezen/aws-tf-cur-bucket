data "aws_iam_policy_document" "key_policy" {
  statement {
    sid = "EnableIamPolicies"
    effect = "Allow"
    resources = ["*"]

    actions = ["kms:*"]

    principals {
      type = "AWS"
      identifiers = [data.aws_billing_service_account.current.arn]
    }
  }
  statement {
    sid       = "AWSConfigKMSPolicy"
    effect    = "Allow"
    resources = ["*"]

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
