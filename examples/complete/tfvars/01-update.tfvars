##############################################################
#variables for backend_ots_lock_instance
##############################################################
backend_oss_bucket        = "terraform-remote-backend-1999"
backend_ots_lock_instance = "tf-oss-backend-update"
backend_ots_lock_table    = "terraform_remote_backend_lock_table_update"
state_name                = "terraform.tfstate-update"
state_path                = "envs:"