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