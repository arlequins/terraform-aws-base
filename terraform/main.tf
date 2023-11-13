#--------------------------------------------------------------
# For IAM Users
#--------------------------------------------------------------
#--------------------------------------------------------------
# Create IAM Users and Group
#--------------------------------------------------------------
# tfsec:ignore:aws-iam-enforce-mfa
module "iam_user_group" {
  count       = lookup(var.iam, "is_enabled", true) ? 1 : 0
  source      = "../modules/iam/user_group"
  user        = lookup(var.iam, "user")
  group       = lookup(var.iam, "group")
  name_prefix = var.name_prefix
}
