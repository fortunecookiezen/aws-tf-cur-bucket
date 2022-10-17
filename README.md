# aws-tf-cur-bucket

Terraform module to create storage location for Cost and Usage Reports

<!-- BEGIN_TF_DOCS -->


## Example

```hcl
module "example" {
  source = "../"
  prefix = "fncz"

  tags = {
    "costcenter" = "1234"
  }

  bucket_tags = {
    "team" = "ccoe"
  }
}

output "billing_id" {
  value = module.example.billing_account
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_tags"></a> [bucket\_tags](#input\_bucket\_tags) | a map of tags for s3 buckets | `map(string)` | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | prefix used for resource naming | `string` | n/a | yes |
| <a name="input_report_bucket_name"></a> [report\_bucket\_name](#input\_report\_bucket\_name) | name of the report destination bucket to be created, defaults to $\{prefix}-cur-reports-$\{region} | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | a map of tags passed to resources | `map(string)` | `{}` | no |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.cost_and_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.cost_and_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.cost_and_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.allow_billing_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.cost_and_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.cost_and_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.cost_and_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_billing_service_account.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/billing_service_account) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_account"></a> [billing\_account](#output\_billing\_account) | n/a |
<!-- END_TF_DOCS -->