variable "backend_oss_bucket" {
  description = "Name of OSS bucket prepared to hold your terraform state(s). If not set, the module will craete one with prefix `terraform-remote-backend`"
  type        = string
  default     = "bucket-170348-versioning"
}

variable "backend_ots_lock_instance" {
  description = "The name of OTS instance to which table belongs."
  type        = string
  default     = "oss-backends"
}

variable "backend_ots_lock_table" {
  description = "OTS table to hold state lock when updating. If not set, the module will craete one with prefix `terraform-remote-backend`"
  type        = string
  default     = "terraform_remote_backend_lock_table_1950"
}

variable "state_name" {
  description = "The name of the state file. Examples: dev/tf.state, dev/frontend/tf.tfstate, etc.."
  type        = string
  default     = "terraform.tfstate"
}

variable "state_path" {
  description = "The path directory of the state file will be stored. Examples: dev/frontend, prod/db, etc.."
  type        = string
  default     = "env:"
}
