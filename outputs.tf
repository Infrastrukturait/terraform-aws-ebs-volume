output "ebs_volume_id" {
  value       = aws_ebs_volume.this.id
  description = "Elastic block storage volume id"
}

output "ebs_volume_arn" {
  value       = aws_ebs_volume.this.arn
  description = "Elastic block storage volume arn"
}

output "backup_hours" {
  value       = try(local.backup_ebs_start, "")
  description = "Time in %HH:%MM format when ebs snapshot is started"
}

output "dlm_role_id" {
  value       = try(aws_iam_role.dlm_lifecycle_role[0].id, "")
  description = "ID dlm lifecycle role"
}

output "dlm_policy_id" {
  value       = try(aws_iam_role_policy.dlm_lifecycle_policy[0].id, "")
  description = "ID dlm lifecycle policy"
}
