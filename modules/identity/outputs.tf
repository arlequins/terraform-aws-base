output "aws_iam_user_login_profile-users" {
  value = {
    for value in aws_iam_user_login_profile.users :
    value.id => { password = value.encrypted_password }
  }
  sensitive = true
}

output "aws_iam_access_key-terraform-id" {
  value     = aws_iam_access_key.terraform.id
  sensitive = true
}

output "aws_iam_access_key-terraform-encrypted_secret" {
  value     = aws_iam_access_key.terraform.encrypted_secret
  sensitive = true
}
