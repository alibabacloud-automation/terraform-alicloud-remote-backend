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

resource "random_uuid" "this" {
}

data "alicloud_regions" "this" {
  current = true
}

# OSS Bucket to hold state.
resource "alicloud_oss_bucket" "this" {
  count  = var.create_backend_bucket ? 1 : 0
  acl    = "private"
  bucket = local.bucket_name

  tags = {
    Name      = "TF remote state"
    Terraform = "true"
  }
}

# OTS table store to lock state during applies
resource "alicloud_ots_instance" "this" {
  count       = var.create_ots_lock_instance ? 1 : 0
  name        = local.lock_table_instance
  description = "Terraform remote backend state lock."
  accessed_by = "Any"
  tags = {
    Purpose = "Terraform state lock for state in ${local.bucket_name}:${var.state_path}/${var.state_name}"
  }
}

resource "alicloud_ots_table" "this" {
  count         = var.create_ots_lock_table ? 1 : 0
  instance_name = var.create_ots_lock_instance ? alicloud_ots_instance.this[0].name : local.lock_table_instance
  max_version   = 1
  table_name    = local.lock_table_name
  time_to_live  = -1
  primary_key {
    name = "LockID"
    type = "String"
  }
}

/* Local file for next init to move state to oss.
   After initial apply, run
    terraform init -force-copy
   to auto-copy state up to oss
*/
resource "local_file" "this" {
  content = <<EOF
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

  filename = "${path.root}/terraform.tf.sample"
}