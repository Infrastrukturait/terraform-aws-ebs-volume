variable "name" {
  type        = string
  description = "Name of ebs volume"
}

variable "create_name_suffix" {
  type        = bool
  description = "always add a random suffix in a resource name."
  default     = true
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone where EBS volume will exist."
}

variable "enable_backup" {
  type        = bool
  description = "Flag to turn on backups. Backup is by default enabled."
  default     = true
}

variable "encrypted" {
  type        = bool
  default     = false
  description = "If true, the disk will be encrypted."
}

variable "final_snapshot" {
  type        = bool
  default     = false
  description = <<EOT
If true, snapshot will be created before volume deletion.
Any tags on the volume will be migrated to the snapshot. **BE AWARE** by default is set to `false`.
EOT
}

variable "iops" {
  type        = number
  default     = 0
  description = "Amount of IOPS to provision for the disk. Only valid for `type` of `io1`, `io2` or `gp3`."
}

variable "multi_attach_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether to enable Amazon EBS Multi-Attach. Multi-Attach is supported on `io1` and `io2` volumes."
}

variable "size" {
  type        = number
  description = "The size of the drive in GiBs"
}

variable "snapshot_id" {
  type        = string
  default     = ""
  description = "A snapshot to base the EBS volume off of"
}

variable "outpost_arn" {
  type        = string
  default     = ""
  description = "The Amazon Resource Name (ARN) of the Outpost"
}

variable "type" {
  type        = string
  default     = "gp2"
  description = "The type of EBS volume. Can be `standard`, `gp2`, `gp3`, `io1`, `io2`, `sc1` or `st1` (Default: `gp2`)"

  validation {
    condition     = contains(["standard", "gp2", "gp3", "io1", "io2", "sc1", "st1"], var.type)
    error_message = "Invalid input, options: standard, gp2, gp3, io1, io2, sc1 or st1."
  }
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = <<EOT
The ARN for the KMS encryption key. When specifying `kms_key_id`, `encrypted` needs to be set to **true**.
Note: Terraform must be running with credentials which have the `GenerateDataKeyWithoutPlaintext` permission on the specified KMS key
as required by the [EBS KMS CMK volume provisioning process](https://docs.aws.amazon.com/kms/latest/developerguide/services-ebs.html#ebs-cmk) to prevent a volume from being created and almost
immediately deleted.
EOT
}

variable "backup_ebs_period" {
  type        = number
  description = "frequency of snapshot in hours (valid values are `1`, `2`, `3`, `4`, `6`, `8`, `12`, or `24`)"
  default     = 24
  validation {
    condition     = contains([1, 2, 3, 4, 6, 8, 12, 24], var.backup_ebs_period)
    error_message = "Invalid backup period."
  }
}

variable "backup_ebs_iam_role_name" {
  type        = string
  description = "The IAM role name for the DLM lifecyle policy"
  default     = "dlm-lifecycle-role"
}

variable "backup_ebs_policy_role_name" {
  type        = string
  description = "The  role name for the DLM lifecyle policy"
  default     = "dlm-lifecycle-policy"
}

variable "backup_ebs_retention" {
  type        = number
  description = "retention period in days"
  default     = 7
}

variable "backup_ebs_start_time" {
  type        = string
  description = "start time in 24 hour format (default is a random time)"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "extra tags"
  default     = {}
}
