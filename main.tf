locals {
  default_bucket_name     = "terraform-remote-backend-${random_uuid.this.result}"
  default_lock_table_name = replace("terraform-remote-backend-lock-table-${random_uuid.this.result}", "-", "_")
  default_lock_instance   = "tf-oss-backend"
  default_region          = var.region != "" ? var.region : data.alicloud_regions.this.ids.0
  bucket_name             = var.backend_oss_bucket != "" ? var.backend_oss_bucket : local.default_bucket_name
  lock_table_instance     = var.backend_ots_lock_instance != "" ? var.backend_ots_lock_instance : local.default_lock_instance
  lock_table_name         = var.backend_ots_lock_table != "" ? var.backend_ots_lock_table : local.default_lock_table_name
  lock_table_endpoint     = "https://${local.lock_table_instance}.${local.default_region}.ots.aliyuncs.com"
}

resource "random_uuid" "this" {}

data "alicloud_regions" "this" {
  current = true
}

# OSS Bucket to hold state.
resource "alicloud_oss_bucket" "this" {
  count  = var.create_backend_bucket ? 1 : 0
  bucket = local.bucket_name
  acl    = var.acl
  tags   = var.oss_tags
}

# OTS table store to lock state during applies
resource "alicloud_ots_instance" "this" {
  count       = var.create_ots_lock_instance ? 1 : 0
  name        = local.lock_table_instance
  description = var.description
  accessed_by = var.accessed_by
  tags        = var.ots_tags
}

resource "alicloud_ots_table" "this" {
  count         = var.create_ots_lock_table ? 1 : 0
  instance_name = local.lock_table_instance
  table_name    = local.lock_table_name
  max_version   = var.max_version
  time_to_live  = var.time_to_live
  primary_key {
    name = var.primary_key_name
    type = var.primary_key_type
  }
}

/* Local file for next init to move state to oss.
   After initial apply, run
    terraform init -force-copy
   to auto-copy state up to oss
*/
resource "local_file" "this" {
  count    = var.create_local_file ? 1 : 0
  content  = <<EOF
    terraform {
      backend "oss" {
        bucket              = "${local.bucket_name}"
        prefix              = "${var.state_path}"
        key                 = "${var.state_name}"
        acl                 = "${var.state_acl}"
        region              = "${local.default_region}"
        encrypt             = "${var.encrypt_state}"
        tablestore_endpoint = "${local.lock_table_endpoint}"
        tablestore_table    = "${local.lock_table_name}"
      }
    }
    EOF
  filename = "${path.root}/${var.filename}"
}