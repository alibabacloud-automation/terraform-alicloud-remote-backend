output "this_oss_bucket_name" {
  description = "The name of the oss instance"
  value       = module.oss_bucket.this_oss_bucket_name
}

output "this_ots_instance_name" {
  description = "The name of the ots instance"
  value       = module.ots_instance.this_ots_instance_name
}

output "this_table_name" {
  description = "The name of the ots table"
  value       = module.ots_table.this_table_name
}