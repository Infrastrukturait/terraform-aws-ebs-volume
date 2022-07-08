variable "region" {
  type      = string
}

variable "name" {
    type    = string
}

variable "availability_zone" {
  type      = string
}

variable "size" {
    type    = number
    default = 8
}

variable "iam_role_name" {
  type        = string
  default     = "dlm-lifecycle-role"
}

variable "policy_role_name" {
  type        = string
  default     = "dlm-lifecycle-policy"  
}