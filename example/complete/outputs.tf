output "ebs_volume_id" {
  value       = module.app_prod_bastion_ebs.ebs_volume_id
}
output "ebs_volume_arn" {
  value       = module.app_prod_bastion_ebs.ebs_volume_arn
}

output "backup_hours" {
  value       = module.app_prod_bastion_ebs.backup_hours
}

output "dlm_role_id" {
  value       = module.app_prod_bastion_ebs.dlm_role_id
}

output "dlm_policy_id" {
  value       = module.app_prod_bastion_ebs.dlm_policy_id
}