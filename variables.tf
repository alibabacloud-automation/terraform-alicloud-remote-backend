#alicloud_oss_bucket
variable "create_backend_bucket" {
  description = "Boolean.  If you have a OSS bucket already, use that one, else make this true and one will be created."
  type        = bool
  default     = false
}

variable "backend_oss_bucket" {
  description = "Name of OSS bucket prepared to hold your terraform state(s). If not set, the module will craete one with prefix `terraform-remote-backend`."
  type        = string
  default     = ""
}

#alicloud_ots_instance
variable "create_ots_lock_instance" {
  description = "Boolean:  If you have a OTS instance already, use that one, else make this true and one will be created."
  type        = bool
  default     = false
}

variable "backend_ots_lock_instance" {
  description = "The name of OTS instance to which table belongs."
  type        = string
  default     = "tf-oss-backend"
}

#alicloud_ots_table
variable "create_ots_lock_table" {
  description = "Boolean:  If you have a ots table already, use that one, else make this true and one will be created."
  type        = bool
  default     = false
}

variable "backend_ots_lock_table" {
  description = "OTS table to hold state lock when updating. If not set, the module will craete one with prefix `terraform-remote-backend`."
  type        = string
  default     = ""
}

#local_file
variable "state_path" {
  description = "The path directory of the state file will be stored. Examples: dev/frontend, prod/db, etc.."
  type        = string
  default     = ""
}

variable "state_name" {
  description = "The name of the state file. Examples: dev/tf.state, dev/frontend/tf.tfstate, etc.."
  type        = string
  default     = ""
}

variable "state_acl" {
  description = "Canned ACL applied to bucket."
  type        = string
  default     = "private"
}

variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "encrypt_state" {
  description = "Boolean. Whether to encrypt terraform state."
  type        = bool
  default     = true
}