data "alicloud_regions" "default" {
  current = true
}

#alicloud_oss_bucket
module "oss_bucket" {
  source = "../.."

  #alicloud_oss_bucket
  create_backend_bucket = true

  backend_oss_bucket = "tf-testacc-oss-bucket-name"
  acl                = var.acl
  oss_tags           = var.oss_tags

  #alicloud_ots_instance
  create_ots_lock_instance = false

  #alicloud_ots_table
  create_ots_lock_table = false

  #local_file
  create_local_file = false

}

#alicloud_ots_instance
module "ots_instance" {
  source = "../.."

  #alicloud_oss_bucket
  create_backend_bucket = false

  #alicloud_ots_instance
  create_ots_lock_instance = true

  backend_ots_lock_instance = "tf-testacc-ots"
  description               = "tf-testacc-ots-description"
  accessed_by               = "Any"
  ots_tags                  = var.ots_tags

  #alicloud_ots_table
  create_ots_lock_table = false

  #local_file
  create_local_file = false

}

#alicloud_ots_table
module "ots_table" {
  source = "../.."

  #alicloud_oss_bucket
  create_backend_bucket = false

  #alicloud_ots_instance
  create_ots_lock_instance = false

  #alicloud_ots_table
  create_ots_lock_table = true

  backend_ots_lock_instance = module.ots_instance.this_ots_instance_name
  backend_ots_lock_table    = "tf_ots_table_name_new"
  max_version               = var.max_version
  time_to_live              = var.time_to_live
  primary_key_name          = "LockID"
  primary_key_type          = "String"

  #local_file
  create_local_file = false

}

module "local_file" {
  source = "../.."

  #alicloud_oss_bucket
  create_backend_bucket = false

  #alicloud_ots_instance
  create_ots_lock_instance = false

  #alicloud_ots_table
  create_ots_lock_table = false

  #local_file
  create_local_file = true

  backend_oss_bucket        = module.oss_bucket.this_oss_bucket_name
  state_path                = var.state_path
  state_name                = var.state_name
  state_acl                 = var.state_acl
  region                    = data.alicloud_regions.default.regions.0.id
  encrypt_state             = var.encrypt_state
  backend_ots_lock_instance = module.ots_instance.this_ots_instance_name
  backend_ots_lock_table    = module.ots_table.this_table_name
  filename                  = "terraform.tf.sample"

}