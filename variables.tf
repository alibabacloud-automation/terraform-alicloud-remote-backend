variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

variable "create_ots_lock_instance" {
  default     = false
  description = "Boolean:  If you have a OTS instance already, use that one, else make this true and one will be created"
}
variable "backend_ots_lock_instance" {
  description = "The name of OTS instance to which table belongs."
  default     = "tf-oss-backend"
}

variable "backend_ots_lock_instance_type" {
  description = "The type for Tablestore (Capacity or HighPerformance)"
  default     = "HighPerformance"
}

variable "create_ots_lock_table" {
  default     = false
  description = "Boolean:  If you have a ots table already, use that one, else make this true and one will be created"
}

variable "backend_ots_lock_table" {
  description = "OTS table to hold state lock when updating. If not set, the module will craete one with prefix `terraform-remote-backend`"
  default     = ""
}

variable "create_backend_bucket" {
  default     = false
  description = "Boolean.  If you have a OSS bucket already, use that one, else make this true and one will be created"
}
variable "backend_oss_bucket" {
  description = "Name of OSS bucket prepared to hold your terraform state(s). If not set, the module will craete one with prefix `terraform-remote-backend`"
  default     = ""
}

variable "state_acl" {
  description = "Canned ACL applied to bucket."
  default     = "private"
}

variable "encrypt_state" {
  default     = true
  description = "Boolean. Whether to encrypt terraform state."
}

variable "state_path" {
  description = "The path directory of the state file will be stored. Examples: dev/frontend, prod/db, etc.."
  default     = "env:"
}

variable "state_name" {
  description = "The name of the state file. Examples: dev/tf.state, dev/frontend/tf.tfstate, etc.."
  default     = "terraform.tfstate"
}