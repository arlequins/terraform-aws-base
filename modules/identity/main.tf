resource "aws_iam_account_alias" "this" {
  account_alias = var.project
}

resource "aws_iam_account_password_policy" "strict" {
  allow_users_to_change_password = true
  hard_expiry                    = false
  max_password_age               = 30
  minimum_password_length        = 14
  password_reuse_prevention      = 12
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
}

resource "aws_accessanalyzer_analyzer" "account" {
  analyzer_name = "account"
  type          = "ACCOUNT"
}

resource "aws_iam_user" "users" {
  for_each = toset(flatten(values(var.users)))

  name = each.value
}

resource "aws_iam_user_login_profile" "users" {
  for_each = aws_iam_user.users

  user    = each.value.name
  pgp_key = var.pgp_key
}
