locals {
    iops                   = contains(["io1", "io2", "gp3"], var.type)  ? var.iops : 0
    multi_attach_enabled   = contains(["io1", "io2"], var.type) ? var.multi_attach_enabled : false
}


resource "aws_ebs_volume" "this" {
  availability_zone    = var.availability_zone
  encrypted            = var.encrypted
  final_snapshot        = var.final_snapshot
  iops                 = local.iops
  multi_attach_enabled = local.multi_attach_enabled
  size                 = var.size
  snapshot_id          = var.snapshot_id
  outpost_arn          = var.outpost_arn
  type                 = var.type
  kms_key_id           = var.kms_key_id
  tags                 = merge(
    var.tags,
    {
      Name = "${var.name}"
    },
  )
}


locals {
  volume_id       = aws_ebs_volume.this.id
  random_start    = var.enable_backup && length(var.backup_ebs_start_time) == 0
}

resource random_integer hour {
  count = local.random_start ? 1 : 0
  max = 23
  min = 0
  keepers = {
    ebs_volume_id = local.volume_id
  }
}

resource random_integer minute {
  count = local.random_start ? 1 : 0
  max = 59
  min = 0
  keepers = {
    ebs_volume_id = local.volume_id
  }
}

locals {
  backup_ebs_start = !local.random_start ? var.backup_ebs_start_time : format("%02d:%02d", random_integer.hour[0].result, random_integer.minute[0].result)
  retention_count = var.backup_ebs_retention * (24 / var.backup_ebs_period)
}

resource "aws_iam_role" "dlm_lifecycle_role" {
  count               = var.enable_backup ? 1 : 0
  name                = var.backup_ebs_iam_role_name
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# DLM lifecycle Policy
resource "aws_iam_role_policy" "dlm_lifecycle_policy" {
  count = var.enable_backup ? 1 : 0
  name  = var.backup_ebs_role_policy_name
  role  = aws_iam_role.dlm_lifecycle_role.*.id

  policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateSnapshot",
        "ec2:DeleteSnapshot",
        "ec2:DescribeVolumes",
        "ec2:DescribeSnapshots"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateTags"
      ],
      "Resource": "arn:aws:ec2:*::snapshot/*"
    }
  ]
}
EOF
}

resource "aws_dlm_lifecycle_policy" "backup" {
  count = var.enable_backup ? 1 : 0
  description = "${var.name} snapshots"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.*.arn
  policy_details {
    resource_types = ["VOLUME"]
    target_tags = {
      Name = var.name
    }
    schedule {
      name = var.name
      create_rule {
        interval = var.backup_ebs_period
        times = [local.backup_ebs_start]
      }
      retain_rule {
        count = local.retention_count
      }
    }
  }
}