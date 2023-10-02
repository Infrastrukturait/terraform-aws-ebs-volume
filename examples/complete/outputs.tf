output "ebs_volume_id" {
  value       = module.app_prod_bastion_ebs.ebs_volume_id
  description = "Elastic block storage volume id"
}
output "ebs_volume_arn" {
  value       = module.app_prod_bastion_ebs.ebs_volume_arn
  description = "Elastic block storage volume arn"
}

output "backup_hours" {
  value       = module.app_prod_bastion_ebs.backup_hours
  description = "Time in %HH:%MM format when ebs snapshot is started"
}

output "dlm_role_id" {
  value       = module.app_prod_bastion_ebs.dlm_role_id
  description = "ID dlm lifecycle role"
}

output "dlm_policy_id" {
  value       = module.app_prod_bastion_ebs.dlm_policy_id
  description = "ID dlm lifecycle policy"
}
