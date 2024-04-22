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

module "remote_state" {
  source = "../.."

  create_backend_bucket = true

  create_ots_lock_instance = true

  # If the specified OTS Instance already exists, you need to set create_ots_lock_instance = false
  backend_ots_lock_instance = "ots-i-${random_integer.default.result}"

  create_ots_lock_table = true
  # Specify a custom OTS Table or use an existing Table with the parameter backend_ots_lock_table
  # If the specified OTS Table already exists, you need to set create_ots_lock_table = false
  # backend_ots_lock_table  = "<your-ots-table-name>"

  region        = var.region
  state_name    = "prod/terraform.tfstate"
  encrypt_state = true
}