variable "region" {
  type        = string
  default     = ""
  description = <<-EOT
    AWS [Region](https://aws.amazon.com/about-aws/global-infrastructure/) to apply example resources.
    The region must be set. Can be set by this variable, also et with either the `AWS_REGION` or `AWS_DEFAULT_REGION` environment variables,
    or via a shared config file parameter region if profile is used.
  EOT
}

variable "name" {
  type        = string
  description = "Name of ebs volume"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone where EBS volume will exist."
}

variable "size" {
  type        = number
  description = "The size of the drive in GiBs"
  default     = 8
}

variable "iam_role_name" {
  type        = string
  description = "The IAM role name for the DLM lifecyle policy"
  default     = "dlm-lifecycle-role"
}

variable "policy_role_name" {
  type        = string
  description = "The  role name for the DLM lifecyle policy"
  default     = "dlm-lifecycle-policy"
}
