#alicloud_oss_bucket
acl = "public-read"
oss_tags = {
  Name = "updateOSS"
}

#alicloud_ots_instance
ots_tags = {
  Name = "updateOTS"
}

#alicloud_ots_table
max_version  = 2
time_to_live = 86400

#local_file
state_path    = "update_dev"
state_name    = "update_dev/update_tf.state"
state_acl     = "public-read"
encrypt_state = false