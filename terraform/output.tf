#--------------------------------------------------------------
# iam Output
#--------------------------------------------------------------
output "iam_user_login_profile" {
  value     = lookup(var.iam, "is_enabled", true) ? module.iam_user_group[0].iam_user_login_profile : null
  sensitive = true
}
output "iam_access_key" {
  value     = lookup(var.iam, "is_enabled", true) ? module.iam_user_group[0].iam_access_key : null
  sensitive = true
}
