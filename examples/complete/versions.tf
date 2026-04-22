terraform {
  required_version = ">= 0.15"
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"

      version = ">= 1.200.0"
    }
  }
}