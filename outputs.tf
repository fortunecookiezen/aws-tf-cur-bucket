output "billing_account" {
  value = data.aws_billing_service_account.current.arn
}