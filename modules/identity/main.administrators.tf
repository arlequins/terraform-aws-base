resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_group_membership" "administrators" {
  name  = aws_iam_group.administrators.name
  users = var.users.administrators
  group = aws_iam_group.administrators.name
}

resource "aws_iam_group_policy_attachment" "administrators" {
  group      = aws_iam_group.administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "administrators-mfa" {
  group      = aws_iam_group.administrators.name
  policy_arn = aws_iam_policy.mfa.arn
}
