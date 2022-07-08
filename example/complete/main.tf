module "app_prod_bastion_label" {
  source   = "cloudposse/label/null"
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
    backup_ebs_role_policy_name = join(module.app_prod_bastion_label.delimiter, [module.app_prod_bastion_label.stage, module.app_prod_bastion_label.name, var.policy_role_name])
    availability_zone           = "${var.availability_zone}"
    size                        = "${var.size}"
    tags                        = module.app_prod_bastion_label.tags
}