output "this_oss_bucket_name" {
  description = "The name of the oss instance"
  value       = concat(alicloud_oss_bucket.this.*.id, [""])[0]
}

output "this_ots_instance_name" {
  description = "The name of the ots instance"
  value       = concat(alicloud_ots_instance.this.*.name, [""])[0]
}

output "this_table_name" {
  description = "The name of the ots table"
  value       = concat(alicloud_ots_table.this.*.table_name, [""])[0]
}