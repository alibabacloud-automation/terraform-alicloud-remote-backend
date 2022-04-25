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

variable "acl" {
  description = "The canned ACL to apply. Can be 'private', 'public-read' and 'public-read-write'."
  type        = string
  default     = "private"
}

variable "oss_tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
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
  default     = ""
}

variable "description" {
  description = "The description of the instance. Currently, it does not support modifying."
  type        = string
  default     = ""
}

variable "accessed_by" {
  description = "The network limitation of accessing instance."
  type        = string
  default     = "Any"
}

variable "ots_tags" {
  description = "A mapping of tags to assign to the instance."
  type        = map(string)
  default     = {}
}

#alicloud_ots_table
variable "create_ots_lock_table" {
  description = "Boolean:  If you have a ots table already, use that one, else make this true and one will be created."
  type        = bool
  default     = false
}

variable "max_version" {
  description = "The maximum number of versions stored in this table."
  type        = number
  default     = 1
}

variable "backend_ots_lock_table" {
  description = "OTS table to hold state lock when updating. If not set, the module will craete one with prefix `terraform-remote-backend`."
  type        = string
  default     = ""
}

variable "time_to_live" {
  description = "The retention time of data stored in this table (unit: second)."
  type        = number
  default     = -1
}

variable "primary_key_name" {
  description = "Name for primary key."
  type        = string
  default     = "LockID"
}

variable "primary_key_type" {
  description = "Type for primary key."
  type        = string
  default     = "String"
}

#local_file
variable "create_local_file" {
  description = "Boolean: If you have a local file already, use that one, else make this true and one will be created."
  type        = bool
  default     = false
}

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

variable "filename" {
  description = "The name of the file."
  type        = string
  default     = "terraform.tf.sample"
}