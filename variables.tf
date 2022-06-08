variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "create_ots_lock_instance" {
  default     = false
  type        = bool
  description = "Boolean:  If you have a OTS instance already, use that one, else make this true and one will be created"
}
variable "backend_ots_lock_instance" {
  description = "The name of OTS instance to which table belongs."
  type        = string
  default     = ""
}

variable "create_ots_lock_table" {
  default     = false
  type        = bool
  description = "Boolean:  If you have a ots table already, use that one, else make this true and one will be created"
}

variable "backend_ots_lock_table" {
  description = "OTS table to hold state lock when updating. If not set, the module will craete one with prefix `terraform-remote-backend`"
  type        = string
  default     = ""
}
variable "create_backend_bucket" {
  default     = false
  type        = bool
  description = "Boolean.  If you have a OSS bucket already, use that one, else make this true and one will be created"
}
variable "backend_oss_bucket" {
  description = "Name of OSS bucket prepared to hold your terraform state(s). If not set, the module will craete one with prefix `terraform-remote-backend`"
  type        = string
  default     = ""
}

variable "state_acl" {
  description = "Canned ACL applied to bucket."
  type        = string
  default     = "private"
}

variable "encrypt_state" {
  default     = true
  type        = bool
  description = "Boolean. Whether to encrypt terraform state."
}

variable "state_path" {
  description = "The path directory of the state file will be stored. Examples: dev/frontend, prod/db, etc.."
  type        = string
  default     = "env:"
}

variable "state_name" {
  description = "The name of the state file. Examples: dev/tf.state, dev/frontend/tf.tfstate, etc.."
  type        = string
  default     = ""
}