terraform {
  required_version = ">= 0.13"
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = ">=1.222.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=2.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">=2.0.0"
    }
  }
}
