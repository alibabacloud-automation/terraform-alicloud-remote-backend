terraform {
  required_providers {
    alicloud = {
      source = "hashicorp/alicloud"
    }
  }
}

variable "region" {
  default = "cn-hangzhou"
}

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

resource "alicloud_kms_key" "kms" {
  origin                 = "Aliyun_KMS"
  protection_level       = "SOFTWARE"
  key_spec               = "Aliyun_AES_256"
  key_usage              = "ENCRYPT/DECRYPT"
  automatic_rotation     = "Disabled"
  pending_window_in_days = 7
}

module "remote_state" {
  source = "../.."

  create_backend_bucket = true
  bucket_logging = [{
    target_bucket = alicloud_oss_bucket.logging.bucket
  }]
  bucket_versioning_status = "Enabled"
  bucket_server_side_encryption = [{
    sse_algorithm       = "KMS"
    kms_master_key_id   = alicloud_kms_key.kms.id
    kms_data_encryption = "SM4"
  }]

  create_ots_lock_instance = true

  # If the specified OTS Instance already exists, you need to set create_ots_lock_instance = false
  backend_ots_lock_instance = "ots-i-${random_integer.default.result}"
  ots_instance_type         = "Capacity"

  create_ots_lock_table = true
  # Specify a custom OTS Table or use an existing Table with the parameter backend_ots_lock_table
  # If the specified OTS Table already exists, you need to set create_ots_lock_table = false
  # backend_ots_lock_table  = "<your-ots-table-name>"

  region        = var.region
  state_name    = "prod/terraform.tfstate"
  encrypt_state = true
}