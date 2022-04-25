#alicloud_oss_bucket
variable "acl" {
  description = "The canned ACL to apply. Can be 'private', 'public-read' and 'public-read-write'."
  type        = string
  default     = "private"
}

variable "oss_tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(string)
  default = {
    Name = "OSS"
  }
}

#alicloud_ots_instance
variable "ots_tags" {
  description = "A mapping of tags to assign to the instance."
  type        = map(string)
  default = {
    Name = "OTS"
  }
}

#alicloud_ots_table
variable "max_version" {
  description = "The maximum number of versions stored in this table."
  type        = number
  default     = 1
}

variable "time_to_live" {
  description = "The retention time of data stored in this table (unit: second)."
  type        = number
  default     = -1
}

#local_file
variable "state_path" {
  description = "The path directory of the state file will be stored. Examples: dev/frontend, prod/db, etc.."
  type        = string
  default     = "dev"
}

variable "state_name" {
  description = "The name of the state file. Examples: dev/tf.state, dev/frontend/tf.tfstate, etc.."
  type        = string
  default     = "dev/tf.state"
}

variable "state_acl" {
  description = "Canned ACL applied to bucket."
  type        = string
  default     = "private"
}

variable "encrypt_state" {
  description = "Boolean. Whether to encrypt terraform state."
  type        = bool
  default     = true
}