variable "prefix" {
  description = "prefix used for resource naming"
  type        = string
}

variable "report_bucket_name" {
  description = "name of the report destination bucket to be created, defaults to $\\{prefix}-cur-reports-$\\{region}"
  type        = string
  default     = ""
}

# variable "billing_account_id" {
#   description = "AWS account id for the master billing account"
#   type        = string
# }

variable "bucket_tags" {
  description = "a map of tags for s3 buckets"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "a map of tags passed to resources"
  type        = map(string)
  default     = {}
}