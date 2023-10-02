
# terraform-aws-ebs-volume

[![WeSupportUkraine](https://raw.githubusercontent.com/Infrastrukturait/WeSupportUkraine/main/banner.svg)](https://github.com/Infrastrukturait/WeSupportUkraine)
## About
Terraform module to create [AWS EBS (Elastic Block Storage)](https://aws.amazon.com/ebs/) volume with
[DLM](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/snapshot-lifecycle.html) policy for automated snapshots as optional
This module support support volume encrypt with [KMS](https://aws.amazon.com/kms/) key 🔑
## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

```text
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Source: <https://opensource.org/licenses/MIT>
```
See [LICENSE](LICENSE) for full details.
## Authors
- Rafał Masiarek | [website](https://masiarek.pl) | [email](mailto:rafal@masiarek.pl) | [github](https://github.com/rafalmasiarek)
<!-- BEGIN_TF_DOCS -->
## Documentation


### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.38.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_dlm_lifecycle_policy.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy) | resource |
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_iam_role.dlm_lifecycle_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.dlm_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [random_integer.hour](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_integer.minute](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability Zone where EBS volume will exist. | `string` | n/a | yes |
| <a name="input_backup_ebs_iam_role_name"></a> [backup\_ebs\_iam\_role\_name](#input\_backup\_ebs\_iam\_role\_name) | The IAM role name for the DLM lifecyle policy | `string` | `"dlm-lifecycle-role"` | no |
| <a name="input_backup_ebs_period"></a> [backup\_ebs\_period](#input\_backup\_ebs\_period) | frequency of snapshot in hours (valid values are `1`, `2`, `3`, `4`, `6`, `8`, `12`, or `24`) | `number` | `24` | no |
| <a name="input_backup_ebs_policy_role_name"></a> [backup\_ebs\_policy\_role\_name](#input\_backup\_ebs\_policy\_role\_name) | The  role name for the DLM lifecyle policy | `string` | `"dlm-lifecycle-policy"` | no |
| <a name="input_backup_ebs_retention"></a> [backup\_ebs\_retention](#input\_backup\_ebs\_retention) | retention period in days | `number` | `7` | no |
| <a name="input_backup_ebs_start_time"></a> [backup\_ebs\_start\_time](#input\_backup\_ebs\_start\_time) | start time in 24 hour format (default is a random time) | `string` | `""` | no |
| <a name="input_create_name_suffix"></a> [create\_name\_suffix](#input\_create\_name\_suffix) | always add a random suffix in a resource name. | `bool` | `true` | no |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | Flag to turn on backups. Backup is by default enabled. | `bool` | `true` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | If true, the disk will be encrypted. | `bool` | `false` | no |
| <a name="input_final_snapshot"></a> [final\_snapshot](#input\_final\_snapshot) | If true, snapshot will be created before volume deletion.<br>Any tags on the volume will be migrated to the snapshot. **BE AWARE** by default is set to `false`. | `bool` | `false` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | Amount of IOPS to provision for the disk. Only valid for `type` of `io1`, `io2` or `gp3`. | `number` | `0` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. When specifying `kms_key_id`, `encrypted` needs to be set to **true**.<br>Note: Terraform must be running with credentials which have the `GenerateDataKeyWithoutPlaintext` permission on the specified KMS key<br>as required by the [EBS KMS CMK volume provisioning process](https://docs.aws.amazon.com/kms/latest/developerguide/services-ebs.html#ebs-cmk) to prevent a volume from being created and almost<br>immediately deleted. | `string` | `""` | no |
| <a name="input_multi_attach_enabled"></a> [multi\_attach\_enabled](#input\_multi\_attach\_enabled) | Specifies whether to enable Amazon EBS Multi-Attach. Multi-Attach is supported on `io1` and `io2` volumes. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of ebs volume | `string` | n/a | yes |
| <a name="input_outpost_arn"></a> [outpost\_arn](#input\_outpost\_arn) | The Amazon Resource Name (ARN) of the Outpost | `string` | `""` | no |
| <a name="input_size"></a> [size](#input\_size) | The size of the drive in GiBs | `number` | n/a | yes |
| <a name="input_snapshot_id"></a> [snapshot\_id](#input\_snapshot\_id) | A snapshot to base the EBS volume off of | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | extra tags | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of EBS volume. Can be `standard`, `gp2`, `gp3`, `io1`, `io2`, `sc1` or `st1` (Default: `gp2`) | `string` | `"gp2"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_hours"></a> [backup\_hours](#output\_backup\_hours) | Time in %HH:%MM format when ebs snapshot is started |
| <a name="output_dlm_policy_id"></a> [dlm\_policy\_id](#output\_dlm\_policy\_id) | ID dlm lifecycle policy |
| <a name="output_dlm_role_id"></a> [dlm\_role\_id](#output\_dlm\_role\_id) | ID dlm lifecycle role |
| <a name="output_ebs_volume_arn"></a> [ebs\_volume\_arn](#output\_ebs\_volume\_arn) | Elastic block storage volume arn |
| <a name="output_ebs_volume_id"></a> [ebs\_volume\_id](#output\_ebs\_volume\_id) | Elastic block storage volume id |

### Examples

```hcl
module "app_prod_bastion_label" {
  source  = "cloudposse/label/null"
  version = "v0.25.0"

  namespace  = "app"
  stage      = "prod"
  name       = "bastion"
  attributes = ["public"]
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "XYZ",
    "Snapshot"     = "true"
  }
}

module "app_prod_bastion_ebs" {
  source                      = "../../"
  encrypted                   = true
  name                        = join(module.app_prod_bastion_label.delimiter, [module.app_prod_bastion_label.stage, module.app_prod_bastion_label.name, var.name])
  backup_ebs_iam_role_name    = join(module.app_prod_bastion_label.delimiter, [module.app_prod_bastion_label.stage, module.app_prod_bastion_label.name, var.iam_role_name])
  backup_ebs_policy_role_name = join(module.app_prod_bastion_label.delimiter, [module.app_prod_bastion_label.stage, module.app_prod_bastion_label.name, var.policy_role_name])
  availability_zone           = var.availability_zone
  size                        = var.size
  tags                        = module.app_prod_bastion_label.tags
}
```

<!-- END_TF_DOCS -->


<!-- references -->

[repo_link]: https://github.com/Infrastrukturait/terraform-aws-ebs-volume
