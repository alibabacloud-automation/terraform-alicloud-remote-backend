provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_oss_bucket" "logging" {
  storage_class = "Standard"
  bucket        = "logging-${random_integer.default.result}"
}

resource "alicloud_ots_instance" "this" {
  name        = "ots-i-${random_integer.default.result}"
  description = "Terraform remote backend state lock."
  accessed_by = "Any"
}

module "remote_state" {
  source = "../.."

  create_backend_bucket = false
  backend_oss_bucket    = alicloud_oss_bucket.logging.bucket


  create_ots_lock_instance  = false
  backend_ots_lock_instance = alicloud_ots_instance.this.name

  create_ots_lock_table = true
  # Specify a custom OTS Table or use an existing Table with the parameter backend_ots_lock_table
  # If the specified OTS Table already exists, you need to set create_ots_lock_table = false
  # backend_ots_lock_table  = "<your-ots-table-name>"

  region        = var.region
  state_name    = "prod/terraform.tfstate"
  encrypt_state = true
}
