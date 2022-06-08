output "backend_oss_bucket_name" {

  value = element(concat(alicloud_oss_bucket.this.*.bucket, [""]), 0)
}

output "backend_ots_instance" {
  value = element(concat(alicloud_ots_instance.this.*.name, [""]), 0)
}

output "backend_ots_table" {
  value = element(concat(alicloud_ots_table.this.*.instance_name, [""]), 0)
}
