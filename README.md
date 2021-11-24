Terraform module to deploy a remote backend storage for Alibaba Cloud  
terraform-alicloud-remote-backend


A terraform module to set up [remote state management](https://www.terraform.io/docs/state/remote.html) with [OSS backend](https://www.terraform.io/docs/backends/types/oss.html) for your account. 
It creates an encrypted OSS bucket to store state files and a OTS table for state locking and consistency checking.

## Features

- Create a OSS bucket to store remote state files.
- Encrypt state files with AES256.
- Create a OTS Instance and table for state locking.
- Export the final oss-backend template named `terraform.tf`.

## Usage

You can use this in your terraform template with the following steps.

```hcl
module "remote_state" {
  source                   = "terraform-alicloud-modules/remote-backend/alicloud"
  create_backend_bucket    = true
  create_ots_lock_instance = true
  create_ots_lock_table    = true
  region                   = "cn-hangzhou"
  state_name               = "prod/terraform.tfstate"
  encrypt_state            = true
}
```

Once the module has been created, you will get a OSS backend in the file `terraform.tf` as follows.

```hcl
terraform {
  backend "oss" {
    bucket              = "THE_NAME_OF_THE_STATE_BUCKET"
    prefix              = "env:"
    key                 = "prod/terraform.tfstate"
    acl                 = "private"
    region              = "cn-hangzhou"
    encrypt             = "true"
    tablestore_endpoint = "https://tf-oss-backend.cn-hangzhou.ots.aliyuncs.com"
    tablestore_table    = "THE_NAME_OF_THE_LOCK_TABLE"
  }
}

```

`THE_NAME_OF_THE_STATE_BUCKET` and `THE_NAME_OF_THE_LOCK_TABLE` prefix with `terraform-remote-backend`.

See [the official document](https://www.terraform.io/docs/backends/types/oss.html#example-configuration) for more detail.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | The region used to launch this module resources. | string | `null` | no |
| create\_ots\_lock\_instance | Boolean:  If you have a ots table already, use that one, else make this true and one will be created. | bool | `false` | no |
| backend\_ots\_lock\_instance | The name of OTS instance to which table belongs. | string | `"tf-oss-backend"` | no |
| create\_ots\_lock\_table | Boolean:  If you have a ots table already, use that one, else make this true and one will be created. | bool | `false` | no |
| backend\_ots\_lock\_table | OTS table to hold state lock when updating. If not set, the module will craete one with prefix `terraform-remote-backend`. | string | "" | no |
| create\_backend\_bucket | Boolean.  If you have a OSS bucket already, use that one, else make this true and one will be created. | bool | `false` | no |
| backend\_oss\_bucket | Name of OSS bucket prepared to hold your terraform state(s). If not set, the module will craete one with prefix `terraform-remote-backend`. | string | "" | no |
| state\_acl | Canned ACL applied to bucket. | string | `"private"` | no |
| encrypt\_state | Boolean. Whether to encrypt terraform state. | object | `true` | no |
| state\_path | The path directory of the state file will be stored. Examples: dev/frontend, prod/db, etc.. | string | `"env:"` | no |
| state\_name | The name of the state file. Examples: dev/tf.state, dev/frontend/tf.tfstate, etc.. | string | `"terraform.tfstate"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  version              = ">=1.56.0"
  region               = var.region != "" ? var.region : null
  configuration_source = "terraform-alicloud-modules/remote-backend"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

```hcl
module "remote_state" {
  source                   = "terraform-alicloud-modules/remote-backend/alicloud"
  version                  = "1.0.0"
  region                   = "cn-beijing"
  create_backend_bucket    = true
  create_ots_lock_instance = true
  // ...
}
```

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region = "cn-beijing"
}
module "remote_state" {
  source                   = "terraform-alicloud-modules/remote-backend/alicloud"
  create_backend_bucket    = true
  create_ots_lock_instance = true
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region = "cn-beijing"
  alias  = "bj"
}
module "remote_state" {
  source                   = "terraform-alicloud-modules/remote-backend/alicloud"
  providers                = {
    alicloud = alicloud.bj
  }
  create_backend_bucket    = true
  create_ots_lock_instance = true
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.2 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.
Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)