module "remote_backend_bucket" {
  source = "../../"
  create_backend_bucket     = true
  create_ots_lock_instance  = false
  create_ots_lock_table     = false
  backend_oss_bucket        = var.backend_oss_bucket
}

module "remote_ots_lock_instance" {
  source = "../../"
  create_backend_bucket         = false
  create_ots_lock_instance      = true
  create_ots_lock_table         = false
  backend_ots_lock_instance     = var.backend_ots_lock_instance
  backend_oss_bucket            = module.remote_backend_bucket.backend_oss_bucket_name
  state_name                    = var.state_name
  state_path                    = var.state_path
}

module "remote_ots_table" {
  source = "../../"
  create_backend_bucket     = false
  create_ots_lock_instance  = false
  create_ots_lock_table     = true
  backend_ots_lock_instance = module.remote_ots_lock_instance.backend_ots_instance
  backend_ots_lock_table    = var.backend_ots_lock_table
}
